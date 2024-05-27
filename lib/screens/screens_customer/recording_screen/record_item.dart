import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pagepals/models/booking_meeting_record_model.dart';
import 'package:pagepals/screens/screens_customer/recording_screen/recording_video_screen.dart';

class RecordItem extends StatelessWidget {
  const RecordItem({
    super.key,
    this.meetingItem,
    this.recordingFile,
    this.number,
  });

  final Record? meetingItem;
  final RecordFile? recordingFile;
  final int? number;

  @override
  Widget build(BuildContext context) {
    String startAt = recordingFile?.startAt ?? '';
    String endAt = recordingFile?.endAt ?? '';
    Duration duration = Duration.zero;
    if (startAt.isEmpty || endAt.isEmpty) {
      duration = Duration.zero;
    } else {
      try {
        if (startAt.contains('ICT') || endAt.contains('ICT')) {
          startAt = startAt.replaceAll('ICT', '');
          endAt = endAt.replaceAll('ICT', '');
          DateFormat inputFormat = DateFormat('EEE MMM dd HH:mm:ss  yyyy');
          DateTime startDateTime = inputFormat.parse(startAt);
          DateTime endDateTime = inputFormat.parse(endAt);
          duration = endDateTime.difference(startDateTime);
        } else {
          DateTime startDateTime = DateTime.parse(startAt);
          DateTime endDateTime = DateTime.parse(endAt);
          duration = endDateTime.difference(startDateTime);
        }
      } catch (e) {
        duration = Duration.zero;
      }
    }

    String startTime = meetingItem?.startTime ?? 'd';
    String date = '';
    String time = '';

    try {
      if (startTime.isEmpty) {
        date = 'unknown';
        time = 'unknown';
      }
      if (startTime.contains('ICT')) {
        startTime = startTime.replaceAll('ICT', '');
        DateFormat inputFormat = DateFormat('EEE MMM dd HH:mm:ss  yyyy');
        DateTime startDateTime = inputFormat.parse(startTime);
        startTime = startDateTime.toString();
      }
      List<String> dateTimeParts = startTime.split(' ');
      if (dateTimeParts.isEmpty) {
        date = 'unknown';
        time = 'unknown';
      }
      date = dateTimeParts[0];
      if (dateTimeParts.length > 1) {
        List<String> timeParts = dateTimeParts[1].split('.');
        if (timeParts.isNotEmpty) {
          time = timeParts[0];
        } else {
          time = 'unknown';
        }
      } else {
        time = 'unknown';
        date = 'unknown';
      }
    } catch (e) {
      date = 'unknown';
      time = 'unknown';
    }

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          PageTransition(
            child: RecordingVideoScreen(
              recordingUrl: recordingFile?.playUrl ?? '',
              recordingId: number ?? 0,
              startTime: meetingItem?.startTime ?? '',
            ),
            type: PageTransitionType.bottomToTop,
            duration: const Duration(milliseconds: 300),
          ),
        );
      },
      child: Row(
        children: [
          Container(
            width: 150,
            height: 100,
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Icon(
                Icons.play_circle_fill,
                size: 90,
                color: Colors.black,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Recording $number',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Date: ${date} ',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              Text(
                'Time: ${time}',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              Text(
                '${duration.toString().split('.')[0]} minutes',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
