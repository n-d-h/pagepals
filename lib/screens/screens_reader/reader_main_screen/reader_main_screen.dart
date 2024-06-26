import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pagepals/helpers/color_helper.dart';
import 'package:pagepals/models/authen_models/account_model.dart';
import 'package:pagepals/models/booking_model.dart';
import 'package:pagepals/models/comment_model.dart';
import 'package:pagepals/models/reader_models/reader_profile_model.dart';
import 'package:pagepals/providers/notification_provider.dart';
import 'package:pagepals/screens/screens_customer/menu_item/menu_item_screen.dart';
import 'package:pagepals/screens/screens_customer/notification_screen/notification_screen.dart';
import 'package:pagepals/screens/screens_reader/feature_screen/completed_booking_screen.dart';
import 'package:pagepals/screens/screens_reader/feature_screen/help_screen.dart';
import 'package:pagepals/screens/screens_reader/feature_screen/reader_cancel_screen.dart';
import 'package:pagepals/screens/screens_reader/feature_screen/reader_comment_screen.dart';
import 'package:pagepals/screens/screens_reader/feature_screen/waiting_screen.dart';
import 'package:pagepals/screens/screens_reader/finance_screen/finance_screen.dart';
import 'package:pagepals/screens/screens_reader/reader_profile/reader_edit_profile_screen.dart';
import 'package:pagepals/screens/screens_reader/report_screen/report_screen.dart';
import 'package:pagepals/services/booking_service.dart';
import 'package:pagepals/services/notification_service.dart';
import 'package:pagepals/services/reader_service.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unicons/unicons.dart';

class ReaderMainScreen extends StatefulWidget {
  final AccountModel? accountModel;

  const ReaderMainScreen({super.key, this.accountModel});

  @override
  State<ReaderMainScreen> createState() => _ReaderMainScreenState();
}

class _ReaderMainScreenState extends State<ReaderMainScreen> {
  late String readerId;
  ReaderProfile? readerProfile;

  BookingModel? pendingBooking;
  BookingModel? completedBooking;
  BookingModel? canceledBooking;
  AccountModel? account;
  CommentModel? commentModel;

  int? unreadCount;

  Future<void> getBooking(String readerId) async {
    var pending =
        await BookingService.getBookingByReader(readerId, 0, 10, 'PENDING');
    var done =
        await BookingService.getBookingByReader(readerId, 0, 10, 'COMPLETE');
    var cancel =
        await BookingService.getBookingByReader(readerId, 0, 10, 'CANCEL');
    var comment = await ReaderService.getListReaderComment(readerId, 0, 10);
    setState(() {
      pendingBooking = pending;
      completedBooking = done;
      canceledBooking = cancel;
      commentModel = comment;
    });
  }

  Future<void> getReaderProfile(String readerId) async {
    ReaderProfile? reader = await ReaderService.getReaderProfile(readerId);
    setState(() {
      readerProfile = reader;
    });
  }

  Future<void> getAccount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accountString = prefs.getString('account');
    if (accountString != null) {
      var jsonData = json.decode(accountString);
      AccountModel accountModel = AccountModel.fromJson(jsonData);
      setState(() {
        account = accountModel;
      });
    }
  }

  Future<void> _fetchNotificationByAccountId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var account = prefs.getString('account');
    AccountModel accountModel = AccountModel.fromJson(json.decode(account!));

    var result = await NotificationService.getAllNotificationByAccountId(
        accountModel.id ?? "", 0, 10, "READER");
    setState(() {
      unreadCount = result.total;
    });
    context.read<NotificationProvider>().setCount(unreadCount!);
  }

  @override
  void initState() {
    super.initState();
    readerId = widget.accountModel!.reader!.id!;
    getBooking(readerId);
    getReaderProfile(readerId);
    getAccount();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.accountModel!.reader!.nickname!);
    double width = MediaQuery.of(context).size.width - 40;
    final notification = context.watch<NotificationProvider>();
    final visible = notification.count > 0;

    return pendingBooking == null ||
            completedBooking == null ||
            canceledBooking == null ||
            commentModel == null
        ? Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: LoadingAnimationWidget.staggeredDotsWave(
                color: Colors.green,
                size: 60,
              ),
            ),
          )
        : Scaffold(
            backgroundColor: Colors.grey[200],
            appBar: AppBar(
              surfaceTintColor: Colors.white,
              backgroundColor: Colors.white,
              title: Text(
                'pagepals.',
                style: TextStyle(
                  color: ColorHelper.getColor(ColorHelper.green),
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    PageTransition(
                      child: const MenuItemScreen(),
                      type: PageTransitionType.leftToRight,
                      duration: const Duration(milliseconds: 300),
                    ),
                    (route) => false,
                  );
                },
              ),
            ),
            body: SingleChildScrollView(
              controller: ScrollController(),
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          PageTransition(
                            child: ReaderEditProfileScreen(
                              readerProfile: readerProfile,
                            ),
                            type: PageTransitionType.rightToLeft,
                          ),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Container(
                                  width: 60,
                                  height: 60,
                                  margin: const EdgeInsets.only(right: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: CircleAvatar(
                                    radius: 30,
                                    backgroundImage: NetworkImage(
                                      widget.accountModel?.reader?.avatarUrl ??
                                          'https://th.bing.com/th/id/OIP.JBpgUJhTt8cI2V05-Uf53AHaG1?rs=1&pid=ImgDetMain',
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    margin: const EdgeInsets.only(right: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          widget.accountModel?.reader
                                                  ?.nickname ??
                                              "",
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        Text(
                                          '@${widget.accountModel!.username!}',
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 12,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Icon(
                              Icons.arrow_forward_ios,
                              size: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    margin: const EdgeInsets.only(bottom: 10),
                    child: FlutterCarousel(
                      options: CarouselOptions(
                        height: 180.0,
                        showIndicator: true,
                        viewportFraction: 1.0,
                        autoPlay: true,
                        slideIndicator: const CircularSlideIndicator(),
                        enableInfiniteScroll: true,
                      ),
                      items: const [
                        Image(
                          image: AssetImage('assets/banner1.jpg'),
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: 180,
                        ),
                        Image(
                          image: AssetImage('assets/banner2.jpg'),
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: 180,
                        ),
                        Image(
                          image: AssetImage('assets/banner3.jpg'),
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: 180,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Bookings',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  PageTransition(
                                    type: PageTransitionType.rightToLeft,
                                    child: WaitingScreen(
                                      readerId: readerId,
                                      bookingModel: pendingBooking,
                                      onLoading: (value) {
                                        if (value) {
                                          setState(() {
                                            pendingBooking = null;
                                            completedBooking = null;
                                            canceledBooking = null;
                                            commentModel = null;
                                          });
                                          getBooking(readerId);
                                        }
                                      },
                                    ),
                                  ),
                                );
                              },
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                width: width / 4,
                                height: 80,
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                        '${pendingBooking!.pagination!.totalOfElements!}'),
                                    const Text(
                                      'Waiting',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 5),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  PageTransition(
                                    type: PageTransitionType.rightToLeft,
                                    child: CompletedBookingScreen(
                                      readerId: readerId,
                                      bookingModel: completedBooking,
                                    ),
                                  ),
                                );
                              },
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                width: width / 4,
                                height: 80,
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                        '${completedBooking!.pagination!.totalOfElements!}'),
                                    const Text(
                                      'Completed',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 5),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  PageTransition(
                                    type: PageTransitionType.rightToLeft,
                                    child: ReaderCancelScreen(
                                      readerId: readerId,
                                      bookingModel: canceledBooking,
                                    ),
                                  ),
                                );
                              },
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                width: width / 4,
                                height: 80,
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                        '${canceledBooking!.pagination!.totalOfElements!}'),
                                    const Text(
                                      'Canceled',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 5),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  PageTransition(
                                    type: PageTransitionType.rightToLeft,
                                    child: ReaderCommentScreen(
                                      commentModel: commentModel,
                                    ),
                                  ),
                                );
                              },
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                width: width / 4,
                                height: 80,
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      '${commentModel?.pagination?.totalOfElements ?? 0}',
                                    ),
                                    const Text(
                                      'Comments',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.only(bottom: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              'Functions',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Container(
                          color: Colors.white,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        PageTransition(
                                          type: PageTransitionType.rightToLeft,
                                          child: FinanceScreen(
                                            accountModel: account,
                                          ),
                                        ),
                                      );
                                    },
                                    borderRadius: BorderRadius.circular(10),
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      width: width / 3,
                                      height: 100,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              color: Colors.yellow,
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                            ),
                                            child: const Icon(
                                              UniconsLine.wallet,
                                              color: Colors.white,
                                              size: 25,
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          const Text(
                                            'Finance',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 13,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        PageTransition(
                                          type: PageTransitionType.rightToLeft,
                                          child: ReportScreen(
                                            accountModel: account,
                                          ),
                                        ),
                                      );
                                    },
                                    borderRadius: BorderRadius.circular(10),
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      width: width / 3,
                                      height: 100,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              color: Colors.redAccent,
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                            ),
                                            child: const Icon(
                                              UniconsLine.chart_bar,
                                              color: Colors.white,
                                              size: 25,
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          const Text(
                                            'Report',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 13,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        PageTransition(
                                          type: PageTransitionType.rightToLeft,
                                          child: HelpScreen(),
                                        ),
                                      );
                                    },
                                    borderRadius: BorderRadius.circular(10),
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      width: width / 3,
                                      height: 100,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              color: Colors.green,
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                            ),
                                            child: const Icon(
                                              UniconsLine.question_circle,
                                              color: Colors.white,
                                              size: 25,
                                            ),
                                          ),
                                          const SizedBox(height: 5),
                                          const Text(
                                            'Help Center',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 13,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
