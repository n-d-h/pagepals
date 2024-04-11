import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pagepals/models/booking_model.dart';
import 'package:pagepals/screens/screens_customer/order_screen/canceled_tab_widgets/cancel_bottom.dart';
import 'package:pagepals/screens/screens_customer/order_screen/completed_tab_widgets/complete_bottom.dart';
import 'package:pagepals/screens/screens_customer/order_screen/completed_tab_widgets/completed_leading.dart';
import 'package:pagepals/screens/screens_customer/order_screen/dashed_seperator.dart';
import 'package:pagepals/screens/screens_customer/order_screen/tab_widgets/booking_body.dart';
import 'package:pagepals/screens/screens_reader/feature_screen/booking_detail_screen.dart';

class CompletedBookingScreen extends StatelessWidget {
  final BookingModel? bookingModel;

  const CompletedBookingScreen({super.key, this.bookingModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Completed Booking'),
        centerTitle: true,
        surfaceTintColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
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
                              title: 'Completed',
                              isEnabled: false,
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
                            CompletedLeading(booking: booking),
                            BookingBody(booking: booking, isReader: true),
                            CanceledBottom(
                              booking: booking,
                              title: 'View Detail',
                              onPressed: () {
                                Navigator.of(context).push(
                                  PageTransition(
                                    child: BookingDetailScreen(
                                      booking: booking,
                                      title: 'Completed',
                                      isEnabled: false,
                                    ),
                                    type: PageTransitionType.rightToLeft,
                                    duration: const Duration(milliseconds: 300),
                                  ),
                                );
                              },
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
