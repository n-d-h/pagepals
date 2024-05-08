import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:crypto/crypto.dart';
import 'package:pagepals/models/authen_models/account_model.dart';
import 'package:pagepals/models/zoom_auth.dart';
import 'package:pagepals/services/authen_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VideoConferenceService {
  static Future<AccountModel> getCustomerAccount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String accountJson = prefs.getString('account')!;
    AccountModel account =
        AccountModel.fromJson(json.decoder.convert(accountJson));
    return account;
  }

  static Future<String> getZoomAuthToken() async {
    var zak = await AuthenService.getZoomAuth();
    print('Zoom token: ${zak}');
    return zak;
  }

  static Future<void> initializeZoomSDK() async {
    const platformChannel = MethodChannel('zoom_sdk_channel');
    String appKey = 'lul5mbunTXSi3Bj451mF8g';
    String appSecret = 'G57osCIVboGCcA6q6w28g8dyvH6v4tNi';
    String jwtToken = generateJWT(appKey, appSecret);
    try {
      var result = await platformChannel.invokeMethod('initializeZoomSDK', {
        'jwtToken': jwtToken,
      });
      debugPrint("Zoom SDK initialization status: $result");
    } catch (e) {
      debugPrint("$e");
    }
  }

  static Future<void> joinMeeting(String meetingId, String password, String displayName) async {
    const platformChannel = MethodChannel('zoom_sdk_channel');
    try {
      await platformChannel.invokeMethod(
        'joinMeeting',
        {
          "meetingID": meetingId,
          "meetingPasscode": password,
          "displayName": displayName,
        },
      );
    } catch (e) {
      debugPrint("$e");
    }
  }

  static Future<void> startMeeting(
    String meetingId,
  ) async {
    const platformChannel = MethodChannel('zoom_sdk_channel');
    String zoomAccessToken = await getZoomAuthToken();
    String nickName = await getCustomerAccount()
        .then((value) => value.reader?.nickname ?? 'Anonymous');
    try {
      final version = await platformChannel.invokeMethod<bool>(
        'startMeeting',
        {
          "meetingID": meetingId,
          "displayName": nickName,
          "zoomAccessToken": zoomAccessToken,
        },
      );
      debugPrint("$version");
    } catch (e) {
      debugPrint("$e");
    }
  }

  static String generateJWT(String appKey, appSecret) {
    // Define header and payload
    Map<String, dynamic> header = {'alg': 'HS256', 'typ': 'JWT'};
    Map<String, dynamic> payload = {
      'appKey': appKey,
      // 'sdkKey': appKey,
      'iat': DateTime.now().millisecondsSinceEpoch ~/ 1000,
      'exp':
          DateTime.now().add(Duration(days: 1)).millisecondsSinceEpoch ~/ 1000,
      'tokenExp':
          DateTime.now().add(Duration(days: 1)).millisecondsSinceEpoch ~/ 1000,
      'role': 1,
    };

    // Encode header and payload to base64Url
    String encodedHeader = base64UrlEncode(utf8.encode(jsonEncode(header)));
    String encodedPayload = base64UrlEncode(utf8.encode(jsonEncode(payload)));

    // Concatenate encoded header and payload with "."
    String dataToSign = '$encodedHeader.$encodedPayload';

    // Compute HMACSHA256 hash with the secret key
    var hmacSha256 = Hmac(sha256, utf8.encode(appSecret));
    var signature =
        base64UrlEncode(hmacSha256.convert(utf8.encode(dataToSign)).bytes);

    // Return the JWT with signature
    return '$dataToSign.$signature';
  }
}
