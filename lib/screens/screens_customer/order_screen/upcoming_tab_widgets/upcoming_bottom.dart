import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pagepals/helpers/color_helper.dart';
import 'package:pagepals/models/booking_model.dart';
import 'package:pagepals/screens/screens_customer/order_screen/video_conference_page.dart';

class UpcomingBottom extends StatelessWidget {
  final Booking booking;

  const UpcomingBottom({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              backgroundColor: ColorHelper.getColor('#C6F4DE'),
              side: const BorderSide(color: Colors.transparent),
              fixedSize: const Size.fromWidth(148),
            ),
            child: Text(
              'Cancel',
              style: GoogleFonts.lexend(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: ColorHelper.getColor(ColorHelper.green),
              ),
            ),
          ),
          OutlinedButton(
            onPressed: () {
              DateTime startTime = DateTime.parse(booking.startAt!);
              if (DateTime.now().isBefore(startTime)) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text("Meeting\nNot Occurred"),
                      content: const Text(
                          "The meeting has not yet occurred. Please come back at the right time."),
                      actions: <Widget>[
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('OK'),
                        ),
                      ],
                    );
                  },
                );
              } else {
                Navigator.of(context).push(
                  PageTransition(
                    child: VideoConferencePage(
                        conferenceID: booking.meeting!.meetingCode!),
                    type: PageTransitionType.fade,
                    duration: const Duration(milliseconds: 300),
                  ),
                );
              }
            },
            style: OutlinedButton.styleFrom(
              backgroundColor: ColorHelper.getColor(ColorHelper.green),
              side: const BorderSide(color: Colors.transparent),
              fixedSize: const Size.fromWidth(148),
            ),
            child: Text(
              'Join meet',
              style: GoogleFonts.lexend(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
