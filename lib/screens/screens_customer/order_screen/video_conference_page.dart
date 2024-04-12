import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pagepals/models/authen_models/account_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zego_uikit_prebuilt_video_conference/zego_uikit_prebuilt_video_conference.dart';

final String appID = dotenv.env['ZEGOCLOUD_APP_ID'] ?? '';
final String appSign = dotenv.env['ZEGOCLOUD_APP_SIGN'] ?? '';

class VideoConferencePage extends StatefulWidget {
  final String conferenceID;

  const VideoConferencePage({
    Key? key,
    required this.conferenceID,
  }) : super(key: key);

  @override
  State<VideoConferencePage> createState() => _VideoConferencePageState();
}

class _VideoConferencePageState extends State<VideoConferencePage> {
  String userId = Random().nextInt(1000000).toString();
  String userName = 'Anonymous';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<void> getCustomerInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String accountJson = prefs.getString('account')!;
    AccountModel account =
        AccountModel.fromJson(json.decoder.convert(accountJson));
    setState(() {
      userId = account.id ?? userId;
      userName = account.username ?? userName;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ZegoUIKitPrebuiltVideoConference(
        appID: int.parse(appID),
        appSign: appSign,
        userID: userId,
        userName: userName,
        conferenceID: widget.conferenceID,
        config: ZegoUIKitPrebuiltVideoConferenceConfig(),
      ),
    );
  }
}
