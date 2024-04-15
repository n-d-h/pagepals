import 'dart:async';
import 'dart:convert';
import 'dart:math';

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
  AccountModel? accountModel;

  @override
  void initState() {
    super.initState();
    getCustomerInfo();
  }

  Future<void> getCustomerInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String accountJson = prefs.getString('account')!;
    AccountModel account =
        AccountModel.fromJson(json.decoder.convert(accountJson));
    setState(() {
      userId = account.id ?? userId;
      userName = account.username ?? userName;
      accountModel = account;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Theme(
        data: ThemeData(
          brightness: Brightness.light,
        ),
        child: ZegoUIKitPrebuiltVideoConference(
          appID: int.parse(appID),
          appSign: appSign,
          userID: userId,
          userName: userName,
          conferenceID: widget.conferenceID,
          config: ZegoUIKitPrebuiltVideoConferenceConfig(
            avatarBuilder: (context, size, user, extraInfo) {
              return Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(accountModel?.customer?.imageUrl ?? ''),
                  ),
                ),
              );
            },
            onError: (ZegoUIKitError onError) {
              print('onError: ${onError.message}');
            },
            onLeaveConfirmation: (context) async {
              return await showDialog<bool>(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Leave the meeting?'),
                    content: const Text(
                      'Are you sure you want to leave the meeting?',
                    ),
                    backgroundColor: Colors.white,
                    surfaceTintColor: Colors.white,
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(true);
                        },
                        child: const Text('Leave'),
                      ),
                    ],
                  );
                },
              );
            },
            topMenuBarConfig: ZegoTopMenuBarConfig(
              hideAutomatically: false,
            ),
            bottomMenuBarConfig: ZegoBottomMenuBarConfig(
              hideAutomatically: false,
            ),
            memberListConfig: ZegoMemberListConfig(
              itemBuilder: (context, size, user, extraInfo) {
                return ListTile(
                  leading: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(
                          accountModel?.customer?.imageUrl ?? '',
                        ),
                      ),
                    ),
                  ),
                  title: Text(user.name ?? ''),
                  subtitle: Text(user.id ?? ''),
                );
              },
            ),
            audioVideoViewConfig: ZegoPrebuiltAudioVideoViewConfig(),
            notificationViewConfig: ZegoInRoomNotificationViewConfig(
              userLeaveItemBuilder: (context, user, extraInfo) {
                return Container();
              },
              userJoinItemBuilder: (context, user, extraInfo) {
                return Container();
              },
            ),
          ),
        ),
      ),
    );
  }
}
