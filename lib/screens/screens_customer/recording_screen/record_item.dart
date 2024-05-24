import 'package:flutter/material.dart';
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
    return InkWell(
      onTap: () {
        print('Recording $number');
        print('Recording URL: ${recordingFile?.playUrl ?? ''}');
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
                (meetingItem?.startTime ?? '').split(' ').length > 0
                    ? (meetingItem?.startTime ?? '').split(' ')[0]
                    : '',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              Text(
                (meetingItem?.startTime ?? '').split(' ').length > 1
                    ? (meetingItem?.startTime ?? '').split(' ')[1]
                    : '',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              Text(
                '${meetingItem?.duration ?? ''} minutes',
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
