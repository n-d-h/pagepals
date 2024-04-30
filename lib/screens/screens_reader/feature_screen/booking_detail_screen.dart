import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pagepals/models/authen_models/account_model.dart';
import 'package:pagepals/models/booking_model.dart';
import 'package:pagepals/screens/screens_customer/booking_screen/booking_widgets/bottom_nav_button.dart';
import 'package:pagepals/screens/screens_customer/booking_screen/summary_widgets/book_row.dart';
import 'package:pagepals/screens/screens_customer/booking_screen/summary_widgets/service_row.dart';
import 'package:pagepals/screens/screens_customer/booking_screen/summary_widgets/time_row.dart';
import 'package:pagepals/screens/screens_reader/feature_screen/customer_info_widget.dart';
import 'package:pagepals/screens/screens_reader/feature_screen/waiting_screen.dart';
import 'package:pagepals/services/booking_service.dart';
import 'package:pagepals/services/setting_service.dart';
import 'package:pagepals/widgets/space_between_row_widget.dart';
import 'package:quickalert/quickalert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mobkit_dashed_border/mobkit_dashed_border.dart';

class BookingDetailScreen extends StatefulWidget {
  final Booking booking;
  final Function(bool)? onLoading;
  final String title;
  final bool isEnabled;

  const BookingDetailScreen({
    required this.booking,
    this.onLoading,
    required this.title,
    required this.isEnabled,
  });

  @override
  State<BookingDetailScreen> createState() => _BookingDetailScreenState();
}

class _BookingDetailScreenState extends State<BookingDetailScreen> {
  bool? isLoading = false;
  int share = 10;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }

  Future<void> init() async {
    Map<String, String> settings = await SettingsService.getAllSettings();
    String? revenueShare = settings['REVENUE_SHARE'];
    setState(() {
      share = revenueShare != null ? int.parse(revenueShare) : share;
    });
  }

  @override
  Widget build(BuildContext context) {
    int amount = (widget.booking.service?.price ?? 0);
    double total = amount - (amount * share / 100);

    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        title: const Text('Booking Detail'),
        centerTitle: true,
        titleTextStyle: const TextStyle(
          fontWeight: FontWeight.w700,
          color: Colors.black,
          fontSize: 24,
        ),
      ),
      body: SingleChildScrollView(
        controller: ScrollController(),
        physics: const BouncingScrollPhysics(),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomerInfoWidget(
                customer: widget.booking.customer,
              ),
              TimeRowWidget(
                time: DateTime.parse(
                    widget.booking.startAt ?? '2024-01-01 00:00:00'),
              ),
              SpaceBetweenRowWidget(
                start: 'Duration',
                end:
                    '${widget.booking.service?.duration?.toInt() ?? 0} minutes',
              ),
              BookRowWidget(book: widget.booking.service?.book?.title ?? ''),
              ServiceRowWidget(
                service: widget.booking.service?.description ?? '',
                serviceType: widget.booking.service?.serviceType?.name ?? '',
              ),
              const SizedBox(height: 16),
              Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 40),
                height: 1,
                color: Colors.black.withOpacity(0.1),
              ),
              SpaceBetweenRowWidget(
                start: 'Amount',
                end: '$amount pals',
              ),
              SpaceBetweenRowWidget(
                start: 'Amount share',
                width: 200,
                end: '$share %',
              ),
              SpaceBetweenRowWidget(
                start: 'Total',
                end: '$total pals',
              ),
              if (widget.booking.state!.name == 'CANCEL')
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      'Cancel Reason',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Colors.black87.withOpacity(0.5),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: DashedBorder.fromBorderSide(
                          dashLength: 5,
                          side: BorderSide(
                            color: Colors.redAccent.shade200,
                            width: 2,
                          ),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          widget.booking.cancelReason ?? '',
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomButton(
        onPressed: () async {
          setState(() {
            isLoading = true;
          });

          bool result =
              await BookingService.completeBooking(widget.booking.id ?? "");
          if (result == false) {
            Future.delayed(const Duration(milliseconds: 300), () {
              setState(() {
                isLoading = false;
              });
              QuickAlert.show(
                context: context,
                type: QuickAlertType.error,
                title: 'Error',
                text:
                    'Meeting has to surpass 40 minutes from the start time to complete',
                autoCloseDuration: const Duration(seconds: 3),
              );
            });
            return;
          } else {
            // Handle button press action here
            Future.delayed(const Duration(milliseconds: 200), () async {
              setState(() {
                isLoading = false;
              });
              widget.onLoading?.call(true);

              // get account
              SharedPreferences prefs = await SharedPreferences.getInstance();
              String accountJson = prefs.getString('account')!;
              AccountModel account =
                  AccountModel.fromJson(json.decoder.convert(accountJson));
              String readerId = account.reader!.id!;

              // Navigate to the next screen
              Navigator.of(context).pushAndRemoveUntil(
                PageTransition(
                  child: WaitingScreen(
                    readerId: readerId,
                    bookingModel: await BookingService.getBookingByReader(
                        readerId, 0, 10, 'PENDING'),
                    isFinished: true,
                  ),
                  type: PageTransitionType.rightToLeft,
                  duration: const Duration(milliseconds: 0),
                ),
                (route) => false,
              );
            });
          }
        },
        isLoading: isLoading,
        title: widget.title,
        isEnabled: widget.isEnabled,
      ),
    );
  }
}
