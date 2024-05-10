import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pagepals/helpers/color_helper.dart';
import 'package:pagepals/models/authen_models/account_model.dart';
import 'package:pagepals/models/booking_model.dart';
import 'package:pagepals/screens/screens_authorization/signin_screen/signin_main/signin_screen.dart';
import 'package:pagepals/screens/screens_customer/order_screen/canceled_tab_widgets/cancel_tab.dart';
import 'package:pagepals/screens/screens_customer/order_screen/completed_tab_widgets/completed_tab.dart';
import 'package:pagepals/screens/screens_customer/order_screen/upcoming_tab_widgets/upcoming_tab.dart';
import 'package:pagepals/services/booking_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unicons/unicons.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  bool isLoading = true;
  BookingModel? pendingBooking;
  BookingModel? completedBooking;
  BookingModel? canceledBooking;

  AccountModel? account;

  Future<void> getPendingBooking() async {
    var pending = await BookingService.getBooking(0, 10, 'PENDING');
    setState(() {
      pendingBooking = pending;
      if (pendingBooking != null) {
        isLoading = false;
      }
    });
  }

  Future<void> getCompleteBooking() async {
    var complete = await BookingService.getBooking(0, 10, 'COMPLETE');
    setState(() {
      completedBooking = complete;
      if (completedBooking != null) {
        isLoading = false;
      }
    });
  }

  Future<void> getCancelBooking() async {
    var cancel = await BookingService.getBooking(0, 10, 'CANCEL');
    setState(() {
      canceledBooking = cancel;
      if (canceledBooking != null) {
        isLoading = false;
      }
    });
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
  void initState() {
    super.initState();
    getAccount();
    getPendingBooking();
  }

  @override
  Widget build(BuildContext context) {
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
        : DefaultTabController(
            initialIndex: 0,
            length: 3,
            child: Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: Colors.white,
                surfaceTintColor: Colors.white,
                title: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    'My Booking',
                    style: GoogleFonts.lexend(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ),
                bottom: TabBar(
                  onTap: (index) {
                    switch (index) {
                      case 0:
                        {
                          setState(() {
                            isLoading = true;
                            pendingBooking = null;
                          });
                          getPendingBooking();
                          break;
                        }
                      case 1:
                        {
                          setState(() {
                            isLoading = true;
                            completedBooking = null;
                          });
                          getCompleteBooking();
                          break;
                        }
                      case 2:
                        {
                          setState(() {
                            isLoading = true;
                            canceledBooking = null;
                          });
                          getCancelBooking();
                          break;
                        }
                    }
                  },
                  isScrollable: false,
                  indicatorColor: ColorHelper.getColor(ColorHelper.green),
                  indicatorSize: TabBarIndicatorSize.tab,
                  labelColor: ColorHelper.getColor(ColorHelper.green),
                  labelStyle: GoogleFonts.lexend(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                  unselectedLabelColor: Colors.grey.shade400,
                  tabs: [
                    Tab(text: AppLocalizations.of(context)!.appUpcoming),
                    Tab(text: AppLocalizations.of(context)!.appCompleted),
                    Tab(text: AppLocalizations.of(context)!.appCanceled),
                  ],
                ),
                // actions: [
                //   IconButton(
                //     onPressed: () {},
                //     icon: const Icon(
                //       UniconsLine.search,
                //       color: Colors.black,
                //     ),
                //   ),
                // ],
              ),
              body: isLoading
                  ? Scaffold(
                      backgroundColor: Colors.white,
                      body: Center(
                        child: LoadingAnimationWidget.staggeredDotsWave(
                          color: Colors.green,
                          size: 60,
                        ),
                      ),
                    )
                  : TabBarView(
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        UpcomingTab(bookingModel: pendingBooking),
                        CompletedTab(bookingModel: completedBooking),
                        CanceledTab(bookingModel: canceledBooking),
                      ],
                    ),
            ),
          );
  }
}
