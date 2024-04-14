import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pagepals/helpers/color_helper.dart';
import 'package:pagepals/models/booking_model.dart';
import 'package:pagepals/screens/screens_customer/order_screen/booking_appointment.dart';
import 'package:pagepals/screens/screens_customer/order_screen/dashed_seperator.dart';
import 'package:pagepals/screens/screens_customer/order_screen/tab_widgets/booking_body.dart';
import 'package:pagepals/screens/screens_customer/order_screen/upcoming_tab_widgets/upcoming_bottom.dart';
import 'package:pagepals/screens/screens_customer/order_screen/upcoming_tab_widgets/upcoming_leading.dart';
import 'package:pagepals/services/booking_service.dart';

class UpcomingTab extends StatefulWidget {
  final BookingModel? bookingModel;

  const UpcomingTab({super.key, this.bookingModel});

  @override
  State<UpcomingTab> createState() => _UpcomingTabState();
}

class _UpcomingTabState extends State<UpcomingTab> {
  int nextPage = 1;
  bool isLoadingNextPage = false;
  bool hasMorePages = true;
  List<Booking> bookings = [];

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController.addListener(_scrollListener);
    bookings.addAll(widget.bookingModel!.list!);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        widget.bookingModel!.pagination!.totalOfElements! > 10) {
      _fetchNextPage();
    }
  }

  Future<void> _fetchNextPage() async {
    if (!isLoadingNextPage && hasMorePages) {
      setState(() {
        isLoadingNextPage = true;
      });
      try {
        var result = await BookingService.getBooking(nextPage, 10, 'PENDING');
        if (result.list!.isEmpty) {
          setState(() {
            hasMorePages = false;
            isLoadingNextPage = false;
          });
        } else {
          setState(() {
            bookings.addAll(result.list!);
            nextPage++;
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

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _scrollController,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: bookings.length + (isLoadingNextPage ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == bookings.length) {
          return Center(
            child: LoadingAnimationWidget.prograssiveDots(
              color: ColorHelper.getColor(ColorHelper.green),
              size: 50,
            ),
          );
        } else {
          Booking booking = bookings[index];
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
                            type: PageTransitionType.rightToLeft,
                            child: BookingAppointment(booking: booking),
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
        }
      },
    );
  }
}
