import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pagepals/helpers/color_helper.dart';
import 'package:pagepals/models/booking_meeting_record_model.dart';
import 'package:pagepals/models/booking_model.dart';
import 'package:pagepals/screens/screens_customer/recording_screen/record_item.dart';
import 'package:pagepals/services/booking_service.dart';

class RecordingScreen extends StatefulWidget {
  const RecordingScreen({super.key, this.booking});

  final Booking? booking;

  @override
  State<RecordingScreen> createState() => _RecordingScreenState();
}

class _RecordingScreenState extends State<RecordingScreen> {
  BookingMeetingRecordModel? bookingMeetingRecordModel;
  int number = 0;

  Future<void> getBookingMeetingRecordings(String id) async {
    var res = await BookingService.getBookingRecordingById(id);
    setState(() {
      bookingMeetingRecordModel = res;
    });
  }

  @override
  void initState() {
    super.initState();
    getBookingMeetingRecordings(widget.booking!.id!);
  }

  @override
  Widget build(BuildContext context) {
    if (bookingMeetingRecordModel == null) {
      return Scaffold(
        body: Center(
          child: LoadingAnimationWidget.staggeredDotsWave(
            color: ColorHelper.getColor(ColorHelper.green),
            size: 60,
          ),
        ),
      );
    } else if (bookingMeetingRecordModel?.meeting == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Recording Screen'),
          surfaceTintColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.videocam_off_outlined,
                size: 200,
              ),
              Text(
                'No Recordings',
                style: TextStyle(
                  fontSize: 40,
                ),
              ),
            ],
          ),
        ),
      );
    } else if ((bookingMeetingRecordModel?.meeting?.records ?? []).isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Recording Screen'),
          surfaceTintColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.videocam_off_outlined,
                size: 200,
              ),
              Text(
                'No Recordings',
                style: TextStyle(
                  fontSize: 40,
                ),
              ),
            ],
          ),
        ),
      );
    }
    setState(() {
      number = 0;
    });
    return Scaffold(
      appBar: AppBar(
        title: Text('Recording Screen'),
        surfaceTintColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        controller: ScrollController(),
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            ...bookingMeetingRecordModel!.meeting!.records!.map(
              (meetingItem) {
                List<RecordFile> recordings = meetingItem.recordFiles ?? [];
                if (recordings.isEmpty) {
                  return Container();
                }
                setState(() {
                  number++;
                });
                var recordingFile = recordings
                    .where((element) => element.fileType == 'MP4')
                    .toList();
                return RecordItem(
                  recordingFile: recordingFile.isNotEmpty
                      ? recordingFile.first
                      : null,
                  meetingItem: meetingItem,
                  number: number,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
