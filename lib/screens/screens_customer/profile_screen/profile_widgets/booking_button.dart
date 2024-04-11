import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pagepals/helpers/color_helper.dart';
import 'package:pagepals/helpers/space_helper.dart';
import 'package:pagepals/models/book_models/book_model.dart';
import 'package:pagepals/models/reader_models/reader_profile_model.dart';
import 'package:pagepals/screens/screens_customer/booking_screen/booking_time_screen.dart';

class ProfileBookingButton extends StatelessWidget {
  final ReaderProfile? reader;
  final Function pauseVideo;
  final BookModel bookModel;

  const ProfileBookingButton(
      {super.key, this.reader, required this.pauseVideo, required this.bookModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(40, 15, 40, 30),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            pauseVideo();
            Navigator.of(context).push(
              PageTransition(
                child: BookingTimeScreen(
                  reader: reader,
                  bookModel: bookModel,
                ),
                type: PageTransitionType.rightToLeft,
                duration: const Duration(milliseconds: 300),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            foregroundColor: ColorHelper.getColor(ColorHelper.white),
            backgroundColor: ColorHelper.getColor(ColorHelper.green),
            padding: const EdgeInsets.symmetric(
              horizontal: SpaceHelper.space16,
              vertical: 9,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Text(
            'Start Booking',
            style: TextStyle(
              fontSize: SpaceHelper.fontSize16,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
