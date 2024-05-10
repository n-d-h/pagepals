import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pagepals/helpers/color_helper.dart';
import 'package:pagepals/main.dart';
import 'package:pagepals/models/authen_models/account_model.dart';
import 'package:pagepals/models/notification_model.dart';
import 'package:pagepals/providers/notification_provider.dart';
import 'package:pagepals/screens/screens_authorization/signin_screen/signin_main/signin_screen.dart';
import 'package:pagepals/screens/screens_customer/notification_screen/notification_helpers/confirm_dialog.dart';
import 'package:pagepals/screens/screens_customer/notification_screen/notification_list_view/notification_list.dart';
import 'package:pagepals/screens/screens_customer/notification_screen/notification_widgets/app_bar_bottom.dart';
import 'package:pagepals/services/notification_service.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationScreen extends StatefulWidget {
  final String role;

  const NotificationScreen({Key? key, required this.role}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  NotificationModel? notificationModel;
  int? unreadCount;
  List<NotificationItem> list = [];
  int currentPage = 0;
  bool isLoadingNextPage = false;
  bool hasMorePages = true;
  AccountModel? account;

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    _fetchNotificationByAccountId();
    getAccount();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _fetchNextPage();
    }
  }

  Future<void> _fetchNotificationByAccountId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var account = prefs.getString('account');
    AccountModel accountModel = AccountModel.fromJson(json.decode(account!));

    var result = await NotificationService.getAllNotificationByAccountId(
        accountModel.id ?? "", currentPage, 10, widget.role);
    setState(() {
      notificationModel = result;
      unreadCount = result.total;
      list.addAll(result.list!);
      currentPage++;
      if (result.list!.isEmpty) {
        hasMorePages = false;
      }
    });
  }

  Future<void> _fetchNextPage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var account = prefs.getString('account');
    AccountModel accountModel = AccountModel.fromJson(json.decode(account!));

    if (!isLoadingNextPage && hasMorePages) {
      setState(() {
        isLoadingNextPage = true;
      });
      try {
        var result = await NotificationService.getAllNotificationByAccountId(
            accountModel.id ?? "", currentPage, 10, widget.role);
        if (result.list!.isEmpty) {
          setState(() {
            hasMorePages = false;
            isLoadingNextPage = false;
          });
        } else {
          setState(() {
            list.addAll(result.list!);
            currentPage++;
            isLoadingNextPage = false;
          });
        }
      } catch (error) {
        print("Error fetching next page: $error");
        setState(() {
          isLoadingNextPage = false;
        });
      }
    }
  }

  Future<void> readAllNotifications() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var account = prefs.getString('account');
    AccountModel accountModel = AccountModel.fromJson(json.decode(account!));

    await NotificationService.readAllNotificationByAccountId(
        accountModel.id ?? "");
  }

  Future<void> readNotification(String id) async {
    await NotificationService.updateReadNotification(id);
  }

  Future<void> getAccount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accountString = prefs.getString('account');
    if (accountString == null) {
      print('No account data found in SharedPreferences');
      return;
    }
    try {
      Map<String, dynamic> accountMap = json.decode(accountString);
      setState(() {
        account = AccountModel.fromJson(accountMap);
      });
    } catch (e) {
      print('Error decoding account data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    var notificationCount = context.watch<NotificationProvider>().count;
    if (notificationCount != unreadCount) {
      setState(() {
        notificationModel = null;
      });
      Future.delayed(const Duration(milliseconds: 40), () {
        _fetchNotificationByAccountId();
      });
    }

    return account == null
        ? Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'You are not logged in',
                    style: GoogleFonts.lexend(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 20),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        PageTransition(
                          child: const SigninScreen(),
                          type: PageTransitionType.bottomToTop,
                          duration: const Duration(milliseconds: 300),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: ColorHelper.getColor(ColorHelper.green),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        'Sign in',
                        style: GoogleFonts.lexend(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              toolbarHeight: 90,
              centerTitle: true,
              surfaceTintColor: Colors.white,
              backgroundColor: Colors.white,
              title: const Text(
                'Notifications',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(0),
                child: NotificationAppBarBottom(
                  unreadCount: unreadCount ?? 0,
                  onReadAllPressed: () {
                    _showConfirmationDialog();
                  },
                ),
              ),
            ),
            body: notificationModel == null
                ? Center(
                    child: LoadingAnimationWidget.staggeredDotsWave(
                      color: ColorHelper.getColor(ColorHelper.green),
                      size: 60,
                    ),
                  )
                : NotificationList(
                    notifications: list,
                    unreadCount: unreadCount ?? 0,
                    onNotificationRead: (index, id) {
                      setState(() {
                        list[index].isRead = true;
                        unreadCount = unreadCount! - 1;
                      });
                      context
                          .read<NotificationProvider>()
                          .setCount(unreadCount!);
                      Future.delayed(Duration.zero, () async {
                        await readNotification(id);
                      });
                    },
                  ),
          );
  }

  void _showConfirmationDialog() {
    ConfirmationDialog.show(context, () {
      setState(() {
        list.forEach((n) => n.isRead = true);
        unreadCount = 0;
      });

      context.read<NotificationProvider>().setCount(0);
      readAllNotifications();
    });
  }
}
