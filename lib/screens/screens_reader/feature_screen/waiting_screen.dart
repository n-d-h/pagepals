import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pagepals/models/authen_models/account_model.dart';
import 'package:pagepals/models/booking_model.dart';
import 'package:pagepals/screens/screens_customer/booking_screen/review_summary_screen.dart';
import 'package:pagepals/screens/screens_customer/order_screen/dashed_seperator.dart';
import 'package:pagepals/screens/screens_customer/order_screen/tab_widgets/booking_body.dart';
import 'package:pagepals/screens/screens_customer/order_screen/upcoming_tab_widgets/upcoming_bottom.dart';
import 'package:pagepals/screens/screens_customer/order_screen/upcoming_tab_widgets/upcoming_leading.dart';
import 'package:pagepals/screens/screens_reader/feature_screen/booking_detail_screen.dart';
import 'package:pagepals/screens/screens_reader/reader_main_screen/reader_main_screen.dart';
import 'package:pagepals/services/authen_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WaitingScreen extends StatelessWidget {
  final BookingModel? bookingModel;
  final Function(bool)? onLoading;

  const WaitingScreen({super.key, this.bookingModel, this.onLoading});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Waiting Booking'),
        centerTitle: true,
        surfaceTintColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () async {
            var account;
            SharedPreferences prefs = await SharedPreferences.getInstance();
            String? accountString = prefs.getString('account');
            if (accountString == null) {
              print('No account data found in SharedPreferences');
              return;
            }
            try {
              Map<String, dynamic> accountMap = json.decode(accountString);
              account = AccountModel.fromJson(accountMap);
            } catch (e) {
              print('Error decoding account data: $e');
            }
            Navigator.of(context).pushAndRemoveUntil(
                PageTransition(
                  child: ReaderMainScreen(accountModel: account),
                  type: PageTransitionType.leftToRight,
                  duration: const Duration(milliseconds: 300),
                ),
                (route) => false);
          },
        ),
      ),
      body: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: bookingModel?.list?.length ?? 0,
        itemBuilder: (context, index) {
          Booking booking = bookingModel!.list![index];
          return Column(
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(20, 25, 20, 0),
                padding: const EdgeInsets.only(bottom: 27),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          PageTransition(
                            child: BookingDetailScreen(
                              booking: booking,
                              onLoading: onLoading,
                              title: 'Finish Booking',
                              isEnabled: DateTime.now().isAfter(
                                DateTime.parse(booking.startAt ??
                                        '2024-01-01 00:00:00')
                                    .add(const Duration(hours: 1)),
                              ),
                              // isEnabled: true,
                            ),
                            type: PageTransitionType.rightToLeft,
                            duration: const Duration(milliseconds: 300),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8)),
                          border: Border.all(
                              width: 0.3, color: Colors.black.withOpacity(0.4)),
                          // boxShadow: [
                          //   BoxShadow(color: Colors.black12, spreadRadius: 2, blurRadius: 3),
                          // ],
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12.withOpacity(0.2),
                              // spreadRadius: 2,
                              blurRadius: 3,
                              offset: const Offset(0, 5),
                            )
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            UpcomingLeading(
                              booking: booking,
                            ),
                            BookingBody(
                              booking: booking,
                              isReader: true,
                            ),
                            UpcomingBottom(
                              booking: booking,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const DashedSeparator(),
            ],
          );
        },
      ),
    );
  }
}
