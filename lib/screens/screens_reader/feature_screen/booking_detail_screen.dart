import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pagepals/helpers/utils.dart';
import 'package:pagepals/models/authen_models/account_model.dart';
import 'package:pagepals/models/book_models/book_model.dart';
import 'package:pagepals/models/booking_model.dart';
import 'package:pagepals/models/reader_models/reader_profile_model.dart';
import 'package:pagepals/screens/screens_customer/booking_screen/booking_success_screen.dart';
import 'package:pagepals/screens/screens_customer/booking_screen/booking_widgets/bottom_nav_button.dart';
import 'package:pagepals/screens/screens_customer/booking_screen/summary_widgets/book_row.dart';
import 'package:pagepals/screens/screens_customer/booking_screen/summary_widgets/service_row.dart';
import 'package:pagepals/screens/screens_customer/booking_screen/summary_widgets/time_row.dart';
import 'package:pagepals/screens/screens_customer/booking_screen/summary_widgets/wallet_widget.dart';
import 'package:pagepals/screens/screens_reader/feature_screen/customer_info_widget.dart';
import 'package:pagepals/screens/screens_reader/feature_screen/waiting_screen.dart';
import 'package:pagepals/services/authen_service.dart';
import 'package:pagepals/services/booking_service.dart';
import 'package:pagepals/widgets/reader_info_widget/reader_info.dart';
import 'package:pagepals/widgets/space_between_row_widget.dart';
import 'package:quickalert/quickalert.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  @override
  Widget build(BuildContext context) {
    int amount = (widget.booking.service?.price ?? 0);
    int promotion = 0;
    double total = amount - (amount * promotion / 100);

    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        title: const Text('Book appointment'),
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
                      widget.booking.startAt ?? '2024-01-01 00:00:00')),
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
                start: 'Promotion',
                end: '$promotion %',
              ),
              SpaceBetweenRowWidget(
                start: 'Total',
                end: '$total pals',
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
                text: 'An error occurred. Please try again.',
                autoCloseDuration: const Duration(seconds: 3),
              );
            });
            return;
          } else {
            // Handle button press action here
            Future.delayed(const Duration(milliseconds: 100), () {
              setState(() {
                isLoading = false;
              });
              widget.onLoading?.call(true);
              Navigator.of(context).pushAndRemoveUntil(
                PageTransition(
                  child: WaitingScreen(),
                  type: PageTransitionType.rightToLeft,
                  duration: const Duration(milliseconds: 300),
                ),
                (route) => false,
              );
            });
            Future.delayed(const Duration(milliseconds: 300), () {
              QuickAlert.show(
                context: context,
                type: QuickAlertType.success,
                title: 'Success',
                text: 'Booking completed successfully.',
                autoCloseDuration: const Duration(seconds: 3),
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
