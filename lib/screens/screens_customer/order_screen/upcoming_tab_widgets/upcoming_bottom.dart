import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pagepals/helpers/color_helper.dart';
import 'package:pagepals/models/booking_model.dart';
import 'package:pagepals/screens/screens_customer/order_screen/canceled_screen.dart';
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
          if (booking.service != null && isReader == false)
            Expanded(
              child: isCancelDisableButton()
                  ? Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.transparent),
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  : OutlinedButton(
                      onPressed: () {
                        if(!isCancelDisableButton()) {
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
                        }
                      },
                      style: OutlinedButton.styleFrom(
                        backgroundColor: ColorHelper.getColor('#C6F4DE'),
                        side: const BorderSide(color: Colors.transparent),
                      ),
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: ColorHelper.getColor(ColorHelper.green),
                        ),
                      ),
                    ),
            ),
          if (booking.service != null && isReader == false)
            const SizedBox(width: 10), // Add this line
          Expanded(
            child: isJoinMeetDisableButton()
                ? Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.transparent),
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        booking.service != null ? 'Join meet' : 'Join seminar',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                : OutlinedButton(
                    onPressed: () async {
                      if(!isJoinMeetDisableButton()) {
                        String userName =
                            await VideoConferenceService.getCustomerAccount()
                                .then((value) => value.username ?? 'Anonymous');
                        await VideoConferenceService.joinMeeting(
                            booking.meeting!.meetingCode!,
                            booking.meeting!.password!,
                            userName);
                      }
                    },
                    style: OutlinedButton.styleFrom(
                      backgroundColor: booking.service != null
                          ? ColorHelper.getColor(ColorHelper.green)
                          : Colors.blueAccent,
                      side: const BorderSide(color: Colors.transparent),
                    ),
                    child: Text(
                      booking.service != null ? 'Join meet' : 'Join seminar',
                      style: TextStyle(
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

  bool isJoinMeetDisableButton() {
    if (booking.startAt == null) {
      return false;
    }
    DateTime startTime = DateTime.parse(booking.startAt!);
    double? duration = booking.service != null
        ? booking.service?.duration?.toDouble() ?? 60
        : booking.event?.seminar?.duration?.toDouble() ?? 60;
    if (DateTime.now().isBefore(startTime)) {
      return true;
    } else if (DateTime.now()
        .isAfter(startTime.add(Duration(minutes: duration.toInt())))) {
      return true;
    }
    return false;
  }

  bool isCancelDisableButton() {
    if (booking.startAt == null) {
      return false;
    }
    DateTime startTime = DateTime.parse(booking.startAt!);
    if (DateTime.now().isBefore(startTime.subtract(
      const Duration(hours: 1),
    ))) {
      return false;
    }
    return true;
  }
}
