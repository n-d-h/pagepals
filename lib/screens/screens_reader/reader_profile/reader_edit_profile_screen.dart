import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pagepals/models/authen_models/account_model.dart';
import 'package:pagepals/models/reader_models/reader_profile_model.dart';
import 'package:pagepals/models/reader_models/reader_update_model.dart';
import 'package:pagepals/providers/reader_update_provider.dart';
import 'package:pagepals/screens/screens_customer/booking_screen/booking_widgets/bottom_nav_button.dart';
import 'package:pagepals/screens/screens_customer/menu_item/menu_item_screen.dart';
import 'package:pagepals/screens/screens_reader/reader_main_screen/reader_main_screen.dart';
import 'package:pagepals/screens/screens_reader/reader_profile/reader_column_edit_field.dart';
import 'package:pagepals/screens/screens_reader/reader_profile/reader_edit_avatar.dart';
import 'package:pagepals/services/authen_service.dart';
import 'package:pagepals/services/file_storage_service.dart';
import 'package:pagepals/services/reader_service.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';
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

  bool isLoading = false;

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
            var account = await AuthenService.getAccountFromSharedPreferences();
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
        onPressed: () async {
          setState(() {
            isLoading = true;
          });
          final readerUpdate = readerUpdateProvider.readerUpdate;

          // Upload video
          final String? updateIntro = readerUpdate.videoUrl;
          final String? oldIntroUrl =
              widget.readerProfile?.profile?.introductionVideoUrl;
          String uploadUrl = '';
          if (updateIntro != null && updateIntro.isNotEmpty) {
            // if (oldIntroUrl != null && oldIntroUrl.isNotEmpty) {
            //   print('oldIntroUrl: $oldIntroUrl');
            //   await FileStorageService.deleteFile(oldIntroUrl);
            // }
            uploadUrl = await FileStorageService.uploadFile(File(updateIntro));
          } else {
            uploadUrl = oldIntroUrl ?? '';
          }

          // Upload image
          final String? updateImage = readerUpdate.avatarUrl;
          final String? oldImageUrl =
              widget.readerProfile?.profile?.avatarUrl;
          String uploadImage = '';
          if (updateImage != null && updateImage.isNotEmpty) {
            if (oldImageUrl != null && oldImageUrl.isNotEmpty) {
              print('oldImageUrl: $oldImageUrl');
              await FileStorageService.deleteFile(oldImageUrl);
            }
            uploadImage = await FileStorageService.uploadFile(File(updateImage));
          } else {
            uploadImage = oldImageUrl ?? '';
          }
          print('uploadImage: $uploadImage');
          print('uploadUrl: $uploadUrl');

          bool isCreated = await ReaderService.updateReader(
            widget.readerProfile?.profile?.id ?? '',
            readerUpdate.nickname ?? nickname,
            uploadImage,
            readerUpdate.countryAccent ?? countryAccent,
            readerUpdate.description ?? description,
            readerUpdate.genres ?? genres,
            readerUpdate.languages ?? languages,
            uploadUrl,
            readerUpdate.audioUrl ?? audioUrl,
          );
          if (isCreated) {
            setState(() {
              isLoading = false;
            });
            Future.delayed(const Duration(milliseconds: 300), () {
              Navigator.of(context).pushAndRemoveUntil(
                  PageTransition(
                    child: MenuItemScreen(),
                    type: PageTransitionType.leftToRight,
                    duration: const Duration(milliseconds: 300),
                  ),
                  (route) => false);
            });
          } else {
            setState(() {
              isLoading = false;
            });
            Future.delayed(const Duration(milliseconds: 300), () {
              QuickAlert.show(
                context: context,
                title: 'Error',
                text: 'Failed to update profile',
                type: QuickAlertType.error,
              );
            });
          }
        },
        isEnabled: true,
        isLoading: isLoading,
      ),
    );
  }
}
