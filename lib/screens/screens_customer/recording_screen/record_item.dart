import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pagepals/models/meeting_model.dart';
import 'package:pagepals/screens/screens_customer/recording_screen/recording_video_screen.dart';

class RecordItem extends StatelessWidget {
  const RecordItem({
    super.key,
    this.meetingItem,
    this.recordingFile,
    this.meetingModel,
  });

  final MeetingItem? meetingItem;
  final RecordingFile? recordingFile;
  final MeetingModel? meetingModel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          PageTransition(
            child: RecordingVideoScreen(
              recordingUrl: meetingItem?.shareUrl ?? '',
              fromDate: meetingModel?.from ?? '',
              toDate: meetingModel?.to ?? '',
              topic: meetingItem?.topic ?? '',
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
                meetingItem?.topic ?? '',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                meetingItem?.startTime ?? '',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              Text(
                '${meetingModel?.from ?? ''} - ${meetingModel?.to ?? ''}',
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
