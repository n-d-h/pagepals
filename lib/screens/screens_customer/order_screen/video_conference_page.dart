// import 'dart:convert';
// import 'dart:math';
//
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:pagepals/models/authen_models/account_model.dart';
// import 'package:pagepals/models/zoom_auth.dart';
// import 'package:pagepals/services/authen_service.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:crypto/crypto.dart';
//
// class VideoConferencePage extends StatefulWidget {
//   final String conferenceID;
//
//   const VideoConferencePage({super.key, required this.conferenceID});
//
//   @override
//   State<VideoConferencePage> createState() => _VideoConferencePageState();
// }
//
// class _VideoConferencePageState extends State<VideoConferencePage> {
//   String userId = Random().nextInt(1000000).toString();
//   String userName = 'Anonymous';
//   AccountModel? accountModel;
//   ZoomAuth? zoomAuth;
//
//   @override
//   void initState() {
//     super.initState();
//     getCustomerInfo();
//     getZoomAuthToken();
//   }
//
//   Future<void> getCustomerInfo() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String accountJson = prefs.getString('account')!;
//     AccountModel account =
//         AccountModel.fromJson(json.decoder.convert(accountJson));
//     setState(() {
//       userId = account.id ?? userId;
//       userName = account.username ?? userName;
//       accountModel = account;
//     });
//   }
//
//   Future<void> getZoomAuthToken() async {
//     var zoom = await AuthenService.getZoomAuth();
//     setState(() {
//       zoomAuth = zoom;
//     });
//   }
//
//   String generateJWT(String appKey, appSecret) {
//     // Define header and payload
//     Map<String, dynamic> header = {'alg': 'HS256', 'typ': 'JWT'};
//     Map<String, dynamic> payload = {
//       'appKey': appKey,
//       'sdkKey': appKey,
//       'iat': DateTime.now().millisecondsSinceEpoch ~/ 1000,
//       'exp':
//           DateTime.now().add(Duration(days: 1)).millisecondsSinceEpoch ~/ 1000,
//       'tokenExp':
//           DateTime.now().add(Duration(days: 1)).millisecondsSinceEpoch ~/ 1000,
//       'role': 1,
//     };
//
//     // Encode header and payload to base64Url
//     String encodedHeader = base64UrlEncode(utf8.encode(jsonEncode(header)));
//     String encodedPayload = base64UrlEncode(utf8.encode(jsonEncode(payload)));
//
//     // Concatenate encoded header and payload with "."
//     String dataToSign = '$encodedHeader.$encodedPayload';
//
//     // Compute HMACSHA256 hash with the secret key
//     var hmacSha256 = Hmac(sha256, utf8.encode(appSecret));
//     var signature =
//         base64UrlEncode(hmacSha256.convert(utf8.encode(dataToSign)).bytes);
//
//     // Return the JWT with signature
//     return '$dataToSign.$signature';
//   }
//
//   void _initializeZoomSDK() async {
//     String appKey = 'lul5mbunTXSi3Bj451mF8g';
//     String appSecret = 'G57osCIVboGCcA6q6w28g8dyvH6v4tNi';
//     final jwt = generateJWT(appKey, appSecret);
//     const platformChannel = MethodChannel('zoom_sdk_channel');
//     try {
//       var result = await platformChannel.invokeMethod('initializeZoomSDK', {
//         'jwtToken': jwt,
//       });
//       debugPrint("Zoom SDK intialization status: $result");
//     } catch (e) {
//       debugPrint("$e");
//     }
//   }
//
//   void _joinMeeting() async {
//     const platformChannel = MethodChannel('zoom_sdk_channel');
//     try {
//       await platformChannel.invokeMethod(
//         'joinMeeting',
//         {
//           "meetingID": "84378732333",
//           "meetingPasscode": "638401",
//           "displayName": userName,
//         },
//       );
//     } catch (e) {
//       debugPrint("$e");
//     }
//   }
//
//   void _startMeeting() async {
//     const platformChannel = MethodChannel('zoom_sdk_channel');
//     try {
//       final version = await platformChannel.invokeMethod<bool>(
//         'startMeeting',
//         {
//           "meetingID": "84378732333",
//           "displayName": userName,
//           "zoomAccessToken": zoomAuth?.accesstoken,
//         },
//       );
//       debugPrint("$version");
//     } catch (e) {
//       debugPrint("$e");
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Video Conference'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ElevatedButton(
//               style: ButtonStyle(
//                 backgroundColor: MaterialStateProperty.all(Colors.blue),
//                 foregroundColor: MaterialStateProperty.all(Colors.white),
//               ),
//               onPressed: () {
//                 _initializeZoomSDK();
//               },
//               child: Text('Initialize Zoom SDK'),
//             ),
//             ElevatedButton(
//               style: ButtonStyle(
//                 backgroundColor: MaterialStateProperty.all(Colors.blue),
//                 foregroundColor: MaterialStateProperty.all(Colors.white),
//               ),
//               onPressed: () {
//                 _joinMeeting();
//               },
//               child: Text('Join Zoom SDK'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
