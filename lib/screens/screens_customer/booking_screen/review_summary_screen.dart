import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pagepals/helpers/color_helper.dart';
import 'package:pagepals/models/book_model.dart';
import 'package:pagepals/models/reader_models/reader_profile_model.dart';
import 'package:pagepals/screens/screens_customer/booking_screen/booking_success_screen.dart';
import 'package:pagepals/screens/screens_customer/booking_screen/booking_widgets/bottom_nav_button.dart';
import 'package:pagepals/screens/screens_customer/booking_screen/summary_widgets/book_row.dart';
import 'package:pagepals/screens/screens_customer/booking_screen/summary_widgets/chapter_row.dart';
import 'package:pagepals/screens/screens_customer/booking_screen/summary_widgets/service_row.dart';
import 'package:pagepals/screens/screens_customer/booking_screen/summary_widgets/time_row.dart';
import 'package:pagepals/screens/screens_customer/booking_screen/summary_widgets/wallet_widget.dart';
import 'package:pagepals/services/booking_service.dart';
import 'package:pagepals/widgets/reader_info_widget/reader_info.dart';
import 'package:pagepals/widgets/space_between_row_widget.dart';
import 'package:quickalert/quickalert.dart';

class ReviewSummaryScreen extends StatelessWidget {
  final ReaderProfile? reader;
  final DateTime time;
  final String timeSlotId;
  final Book? book;
  final Services? service;

  // final String? chapter;
  final ServiceType? serviceType;

  const ReviewSummaryScreen({
    super.key,
    this.reader,
    required this.time,
    required this.book,
    // required this.chapter,
    required this.serviceType,
    this.service,
    required this.timeSlotId,
  });

  String formatPrice(double priceInDong) {
    // Check if priceInDong is in cents or dong
    if (priceInDong < 100) {
      // If priceInDong is less than 100, assume it's already in dong
      priceInDong *= 100; // Convert it to cents
    }

    // Create a NumberFormat instance for formatting the price with thousands separators
    NumberFormat format = NumberFormat("#,##0", "en_US");

    // Format the price with thousands separators
    String formattedPrice = format.format(priceInDong);

    // Add " VND" suffix and replace commas with dots
    formattedPrice += " VND";
    formattedPrice = formattedPrice.replaceAll(',', '.');

    return formattedPrice;
  }

  @override
  Widget build(BuildContext context) {
    double amount = (service?.price ?? 0) * 23000;
    double total = amount + 3000;
    print('amount: $amount');
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
              ReaderInfoWidget(
                reader: reader,
              ),
              TimeRowWidget(time: time),
              SpaceBetweenRowWidget(
                start: 'Duration',
                end: '${service!.duration!.toInt()} minutes',
              ),
              BookRowWidget(book: book!.title!),
              ServiceRowWidget(
                service: service!.description!,
                serviceType: serviceType!.name!,
              ),
              const SizedBox(height: 15),
              SpaceBetweenRowWidget(
                start: 'Amount',
                end: formatPrice(amount),
              ),
              const SpaceBetweenRowWidget(
                  start: 'Service fees', end: '3.000 VND'),
              SpaceBetweenRowWidget(
                start: 'Total',
                end: formatPrice(total),
              ),
              const WalletWidget(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomButton(
        onPressed: () async {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return Center(
                child: SizedBox(
                  height: 50,
                  width: 50,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(
                      ColorHelper.getColor(ColorHelper.green),
                    ),
                  ),
                ),
              );
            },
          );

          bool bookingCreated =
              await BookingService.createBooking("", service!, timeSlotId, "");
          if (!bookingCreated) {
            Future.delayed(const Duration(milliseconds: 300), () {
              Navigator.of(context).pop();
              QuickAlert.show(
                context: context,
                type: QuickAlertType.error,
                title: 'Error',
                text: 'An error occurred while booking. Please try again.',
                autoCloseDuration: const Duration(seconds: 3),
              );
            });
            return;
          } else {
            // Handle button press action here
            Future.delayed(Duration.zero, () {
              Navigator.of(context).pop();
              Navigator.of(context).push(
                PageTransition(
                  child: BookingSuccessScreen(reader: reader),
                  type: PageTransitionType.rightToLeft,
                  duration: const Duration(milliseconds: 300),
                ),
              );
            });
            Future.delayed(const Duration(milliseconds: 300), () {
              QuickAlert.show(
                context: context,
                type: QuickAlertType.success,
                title: 'Success Booking',
                text: 'Thank you for booking!',
                autoCloseDuration: const Duration(seconds: 3),
              );
            });
          }
        },
        title: 'Pay Now',
        isEnabled: true,
      ),
    );
  }
}
