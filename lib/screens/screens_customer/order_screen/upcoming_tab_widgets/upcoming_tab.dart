import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pagepals/models/booking_model.dart';
import 'package:pagepals/screens/screens_customer/order_screen/dashed_seperator.dart';
import 'package:pagepals/screens/screens_customer/order_screen/upcoming_tab_widgets/upcoming_body.dart';
import 'package:pagepals/screens/screens_customer/order_screen/upcoming_tab_widgets/upcoming_bottom.dart';
import 'package:pagepals/screens/screens_customer/order_screen/upcoming_tab_widgets/upcoming_leading.dart';
import 'package:pagepals/screens/screens_customer/order_screen/video_conference_page.dart';
import 'package:pagepals/services/booking_service.dart';

class UpcomingTab extends StatefulWidget {
  const UpcomingTab({super.key});

  @override
  State<UpcomingTab> createState() => _UpcomingTabState();
}

class _UpcomingTabState extends State<UpcomingTab> {
  BookingModel? bookingModel;

  Future<void> getBooking() async {
    var result = await BookingService.getBooking(1, 10);
    setState(() {
      bookingModel = result;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getBooking();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 75),
      child: ListView.builder(
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
                      },
                      child: Container(
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.all(Radius.circular(8)),
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
                            UpcomingLeading(booking: booking,),
                            UpcomingBody(booking: booking,),
                            UpcomingBottom(booking: booking,),
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
