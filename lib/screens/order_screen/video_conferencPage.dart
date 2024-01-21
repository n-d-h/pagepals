import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pagepals/helpers/app_settings.dart';
import 'package:zego_uikit_prebuilt_video_conference/zego_uikit_prebuilt_video_conference.dart';

final userId = Random().nextInt(1000000).toString();
const userName = 'Huy Nguyen';

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
        appID: AppSettings.appId,
        appSign: AppSettings.appSign,
        userID: userId,
        userName: userName,
        conferenceID: conferenceID,
        config: ZegoUIKitPrebuiltVideoConferenceConfig(),
      ),
    );
  }
}
