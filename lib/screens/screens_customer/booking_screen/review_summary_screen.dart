import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pagepals/models/reader_models/reader_profile_model.dart';
import 'package:pagepals/screens/screens_customer/booking_screen/booking_success_screen.dart';
import 'package:pagepals/screens/screens_customer/booking_screen/booking_widgets/bottom_nav_button.dart';
import 'package:pagepals/screens/screens_customer/booking_screen/summary_widgets/book_row.dart';
import 'package:pagepals/screens/screens_customer/booking_screen/summary_widgets/chapter_row.dart';
import 'package:pagepals/screens/screens_customer/booking_screen/summary_widgets/service_row.dart';
import 'package:pagepals/screens/screens_customer/booking_screen/summary_widgets/time_row.dart';
import 'package:pagepals/screens/screens_customer/booking_screen/summary_widgets/wallet_widget.dart';
import 'package:pagepals/widgets/reader_info_widget/reader_info.dart';
import 'package:pagepals/widgets/space_between_row_widget.dart';
import 'package:quickalert/quickalert.dart';

class ReviewSummaryScreen extends StatelessWidget {
  final ReaderProfile? reader;
  final DateTime time;
  final String? book;
  // final String? chapter;
  final int? serviceType;

  const ReviewSummaryScreen(
      {super.key,
      this.reader,
      required this.time,
      required this.book,
      // required this.chapter,
      required this.serviceType});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
              ServiceRowWidget(service: serviceType!),
              BookRowWidget(book: book!),
              // ChapterRowWidget(chapter: chapter!),
              const SizedBox(height: 15),
              const SpaceBetweenRowWidget(start: 'Amount', end: '15.000 VND'),
              const SpaceBetweenRowWidget(
                  start: 'Service fees', end: '3.000 VND'),
              const SpaceBetweenRowWidget(start: 'Total', end: '18.000 VND'),
              const WalletWidget(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomButton(
        onPressed: () {
          // Handle button press action here
          Navigator.of(context).push(
            PageTransition(
              child: BookingSuccessScreen(reader: reader),
              type: PageTransitionType.rightToLeft,
              duration: const Duration(milliseconds: 300),
            ),
          );
          Future.delayed(const Duration(milliseconds: 300), () {
            QuickAlert.show(
              context: context,
              type: QuickAlertType.success,
              title: 'Success Booking',
              text: 'Thank you for booking!',
              autoCloseDuration: const Duration(seconds: 3),
            );
          });
        }, // Disable button if fields are not selected
        title: 'Pay Now',
        isEnabled: true,
      ),
    );
  }
}
