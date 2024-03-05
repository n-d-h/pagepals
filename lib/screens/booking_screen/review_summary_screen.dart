import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pagepals/models/reader_models/reader_profile_model.dart';
import 'package:pagepals/screens/booking_screen/booking_widgets/bottom_nav_button.dart';
import 'package:pagepals/screens/booking_screen/summary_widgets/time_row.dart';
import 'package:pagepals/widgets/reader_info_widget/reader_info.dart';

class ReviewSummaryScreen extends StatelessWidget {
  final ReaderProfile? reader;
  final DateTime time;
  final String? book;
  final String? chapter;
  final int? serviceType;

  const ReviewSummaryScreen(
      {super.key,
      this.reader,
      required this.time,
      required this.book,
      required this.chapter,
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
              TimeRowWidget(time: time)
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomButton(
        onPressed: () {
          // Handle button press action here
        }, // Disable button if fields are not selected
        title: 'Pay Now',
        isEnabled: true,
      ),
    );
  }
}
