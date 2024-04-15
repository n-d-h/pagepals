import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pagepals/helpers/color_helper.dart';
import 'package:pagepals/models/authen_models/account_model.dart';
import 'package:pagepals/models/reader_models/reader_profile_model.dart';
import 'package:pagepals/screens/screens_customer/booking_screen/booking_widgets/bottom_nav_button.dart';
import 'package:pagepals/screens/screens_reader/reader_main_screen/reader_main_screen.dart';
import 'package:pagepals/screens/screens_reader/reader_profile/reader_column_edit_field.dart';
import 'package:pagepals/screens/screens_reader/reader_profile/reader_edit_avatar.dart';
import 'package:pagepals/screens/screens_reader/reader_profile/reader_edit_field.dart';
import 'package:pagepals/screens/screens_reader/reader_request/video_player_from_file.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReaderEditProfileScreen extends StatefulWidget {
  const ReaderEditProfileScreen({super.key, this.readerProfile});

  final ReaderProfile? readerProfile;

  @override
  State<ReaderEditProfileScreen> createState() =>
      _ReaderEditProfileScreenState();
}

class _ReaderEditProfileScreenState extends State<ReaderEditProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Reader Profile'),
        centerTitle: true,
        surfaceTintColor: Colors.grey[100],
        backgroundColor: Colors.grey[100],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () async {
            var account;
            SharedPreferences prefs = await SharedPreferences.getInstance();
            String? accountString = prefs.getString('account');
            if (accountString == null) {
              print('No account data found in SharedPreferences');
              return;
            }
            try {
              Map<String, dynamic> accountMap =
                  json.decoder.convert(accountString);
              account = AccountModel.fromJson(accountMap);
            } catch (e) {
              print('Error decoding account data: $e');
            }
            Navigator.of(context).pushAndRemoveUntil(
                PageTransition(
                  child: ReaderMainScreen(accountModel: account),
                  type: PageTransitionType.leftToRight,
                  duration: const Duration(milliseconds: 300),
                ),
                (route) => false);
          },
        ),
      ),
      body: SingleChildScrollView(
        controller: ScrollController(),
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ReaderEditAvatar(readerProfile: widget.readerProfile),
            Container(
              // padding: const EdgeInsets.only(left: 20),
              width: double.infinity,
              child: Text(
                textAlign: TextAlign.center,
                'Personal Information',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black45,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: ReaderColumnEditField(readerProfile: widget.readerProfile),
            ),
          ],
        ),
      ),
    );
  }
}
