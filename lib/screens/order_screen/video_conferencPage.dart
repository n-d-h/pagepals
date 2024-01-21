import 'dart:math';

import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_video_conference/zego_uikit_prebuilt_video_conference.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final userId = Random().nextInt(1000000).toString();
const userName = 'Huy Nguyen';

final String appID = dotenv.env['ZEGOCLOUD_APP_ID'] ?? '';
final String appSign = dotenv.env['ZEGOCLOUD_APP_SIGN'] ?? '';

class VideoConferencePage extends StatelessWidget {
  final String conferenceID;

  const VideoConferencePage({
    Key? key,
    required this.conferenceID,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ZegoUIKitPrebuiltVideoConference(
        appID: int.parse(appID),
        appSign: appSign,
        userID: userId,
        userName: userName,
        conferenceID: conferenceID,
        config: ZegoUIKitPrebuiltVideoConferenceConfig(),
      ),
    );
  }
}
