import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pagepals/models/authen_models/account_model.dart';
import 'package:pagepals/models/reader_models/reader_profile_model.dart';
import 'package:pagepals/models/reader_models/reader_update_model.dart';
import 'package:pagepals/providers/reader_update_provider.dart';
import 'package:pagepals/screens/screens_customer/booking_screen/booking_widgets/bottom_nav_button.dart';
import 'package:pagepals/screens/screens_reader/reader_main_screen/reader_main_screen.dart';
import 'package:pagepals/screens/screens_reader/reader_profile/reader_column_edit_field.dart';
import 'package:pagepals/screens/screens_reader/reader_profile/reader_edit_avatar.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReaderEditProfileScreen extends StatefulWidget {
  const ReaderEditProfileScreen(
      {super.key, this.readerProfile, this.readerUpdate});

  final ReaderProfile? readerProfile;
  final ReaderUpdate? readerUpdate;

  @override
  State<ReaderEditProfileScreen> createState() =>
      _ReaderEditProfileScreenState();
}

class _ReaderEditProfileScreenState extends State<ReaderEditProfileScreen> {
  late String avatarUrl;
  late String nickname;
  late String genres;
  late String languages;
  late String videoUrl;
  late String audioUrl;
  late String countryAccent;
  late String description;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    avatarUrl = widget.readerUpdate?.avatarUrl ??
        widget.readerProfile?.profile?.avatarUrl ??
        '';
    nickname = widget.readerUpdate?.nickname ??
        widget.readerProfile?.profile?.nickname ??
        '';
    genres = widget.readerUpdate?.genres ??
        widget.readerProfile?.profile?.genre ??
        '';
    languages = widget.readerUpdate?.languages ??
        widget.readerProfile?.profile?.language ??
        '';
    videoUrl = widget.readerUpdate?.videoUrl ??
        widget.readerProfile?.profile?.introductionVideoUrl ??
        '';
    audioUrl = widget.readerUpdate?.audioUrl ??
        widget.readerProfile?.profile?.audioDescriptionUrl ??
        '';
    countryAccent = widget.readerUpdate?.countryAccent ??
        widget.readerProfile?.profile?.countryAccent ??
        '';
    description = widget.readerUpdate?.description ??
        widget.readerProfile?.profile?.description ??
        '';
  }

  @override
  Widget build(BuildContext context) {
    final readerUpdateProvider = context.watch<ReaderUpdateProvider>();
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
            readerUpdateProvider.clear();
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
            ReaderEditAvatar(
              readerProfile: widget.readerProfile,
              readerUpdate: widget.readerUpdate,
              onAvatarChanged: (value) {
                setState(() {
                  avatarUrl = value;
                  final readerUpdateProvider =
                      context.read<ReaderUpdateProvider>();
                  readerUpdateProvider.updateReaderUpdateModel(
                      avatarUrl: avatarUrl);
                });
              },
            ),
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
              child: ReaderColumnEditField(
                readerProfile: widget.readerProfile,
                readerUpdate: widget.readerUpdate,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomButton(
        title: 'Save Changes',
        onPressed: () {
          final readerUpdate = readerUpdateProvider.readerUpdate;
          print(readerUpdate);
          // readerUpdateProvider.clearReaderUpdateModel();
        },
        isEnabled: true,
        isLoading: false,
      ),
    );
  }
}
