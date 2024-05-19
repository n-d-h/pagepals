import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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

class ProcessingTab extends StatefulWidget {
  final BookingModel? bookingModel;

  const ProcessingTab({super.key, this.bookingModel});

  @override
  State<ProcessingTab> createState() => _ProcessingTabState();
}

class _ProcessingTabState extends State<ProcessingTab> {
  int nextPage = 1;
  bool isLoadingNextPage = false;
  bool hasMorePages = true;
  List<Booking> bookings = [];

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    bookings.addAll(widget.bookingModel!.list!);
  }

  @override
  void dispose() {
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
        var result =
            await BookingService.getBooking(nextPage, 10, 'PROCESSING');
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
    return bookings.isEmpty
        ? Center(
            child: Container(
              // margin appbar height + 20
              margin: const EdgeInsets.only(bottom: 80),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/no_booking.png',
                    width: 250,
                    height: 250,
                    fit: BoxFit.fill,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Empty List',
                    style: GoogleFonts.caveatBrush(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'You have no booking yet.',
                    overflow: TextOverflow.clip,
                    style: GoogleFonts.openSans(
                      color: Colors.black54,
                      fontSize: 18,
                    ),
                  )
                ],
              ),
            ),
          )
        : ListView.builder(
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
                                  child: BookingAppointment(
                                    booking: booking,
                                    isVisible: false,
                                  ),
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
                                  width: 0.3,
                                  color: Colors.black.withOpacity(0.4),
                                ),
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
                                    isReader: false,
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
