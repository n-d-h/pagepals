import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pagepals/helpers/color_helper.dart';
import 'package:pagepals/models/booking_model.dart';
import 'package:pagepals/screens/screens_customer/order_screen/canceled_screen.dart';
import 'package:pagepals/screens/screens_customer/order_screen/video_conference_page.dart';
import 'package:pagepals/services/video_conference_service.dart';

class UpcomingBottom extends StatelessWidget {
  final Booking booking;
  final bool isReader;

  const UpcomingBottom({
    super.key,
    required this.booking,
    required this.isReader,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (booking.service != null || !isReader)
            Expanded(
              child: OutlinedButton(
                onPressed: () {
                  if (booking.startAt != null &&
                      DateTime.now().isBefore(
                        DateTime.parse(booking.startAt!).add(
                          const Duration(
                            days: 1,
                          ),
                        ),
                      )) {
                    Navigator.of(context).push(
                      PageTransition(
                        child: CanceledScreen(
                          isReader: isReader,
                          bookingId: booking.id!,
                          onValueChanged: (value) {
                            print(value);
                          },
                        ),
                        type: PageTransitionType.rightToLeftWithFade,
                        duration: const Duration(milliseconds: 300),
                      ),
                    );
                  } else if (booking.startAt != null &&
                      DateTime.now().isAfter(
                        DateTime.parse(booking.startAt!).add(
                          const Duration(
                            minutes: 45,
                          ),
                        ),
                      )) {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text("Meeting expired"),
                            content: const Text(
                              "The meeting has expired. You can't cancel it now.",
                            ),
                            actions: <Widget>[
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          );
                        });
                  } else {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text("Meeting scheduled"),
                            content: const Text(
                              "The meeting is almost starting. You can't cancel it now.",
                            ),
                            actions: <Widget>[
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          );
                        });
                  }
                },
                style: OutlinedButton.styleFrom(
                  backgroundColor: ColorHelper.getColor('#C6F4DE'),
                  side: const BorderSide(color: Colors.transparent),
                  // fixedSize: const Size.fromWidth(148),
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
            ),
          const SizedBox(width: 10), // Add this line
          Expanded(
            child: OutlinedButton(
              onPressed: () async {
                DateTime startTime = DateTime.parse(booking.startAt!);
                if (DateTime.now().isBefore(startTime)) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        surfaceTintColor: Colors.white,
                        title: const Text("Meeting\nNot Occurred"),
                        content: const Text(
                          "The meeting has not yet occurred. Please come back at the right time.",
                        ),
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
                } else if (DateTime.now()
                    .isAfter(startTime.add(const Duration(minutes: 45)))) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("Meeting Expired"),
                        content: const Text(
                          "The meeting has expired. Please contact the service provider for more information.",
                        ),
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
                  double? duration = booking.service != null
                      ? booking.service!.duration!
                      : booking.seminar!.duration!.toDouble();
                  if (DateTime.now().isAfter(
                      startTime.add(Duration(minutes: duration!.toInt())))) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          surfaceTintColor: Colors.white,
                          title: const Text("Meeting Expired"),
                          content: const Text(
                            "The meeting has expired. Please contact the reader for further information.",
                          ),
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
                    return;
                  }

                  if(isReader) {
                    await VideoConferenceService.startMeeting(
                        booking.meeting!.meetingCode!);
                  } else {
                    await VideoConferenceService.joinMeeting(
                        booking.meeting!.meetingCode!,
                        booking.meeting!.password!);
                  }
                }
              },
              style: OutlinedButton.styleFrom(
                backgroundColor: booking.service != null
                    ? ColorHelper.getColor(ColorHelper.green)
                    : Colors.blueAccent,
                side: const BorderSide(color: Colors.transparent),
              ),
              child: Text(
                // booking.service != null ? 'Join meet' : 'Join seminar',
                'Join meet',
                style: GoogleFonts.lexend(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
