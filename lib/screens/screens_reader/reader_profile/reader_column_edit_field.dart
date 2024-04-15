import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:pagepals/models/reader_models/reader_profile_model.dart';
import 'package:pagepals/screens/screens_reader/reader_profile/edit_utils.dart';
import 'package:pagepals/screens/screens_reader/reader_profile/reader_edit_field.dart';
import 'package:pagepals/screens/screens_reader/reader_profile/upload_button.dart';
import 'package:pagepals/screens/screens_reader/reader_request/video_player_from_file.dart';
import 'package:pagepals/services/reader_service.dart';

class ReaderColumnEditField extends StatefulWidget {
  final ReaderProfile? readerProfile;

  const ReaderColumnEditField({super.key, this.readerProfile});

  @override
  State<ReaderColumnEditField> createState() => _ReaderColumnEditFieldState();
}

class _ReaderColumnEditFieldState extends State<ReaderColumnEditField> {
  String nickname = 'Nick name';
  String genres = 'Fiction, Non-fiction';
  String languages = 'English';
  String videoUrl =
      'https://www.learningcontainer.com/wp-content/uploads/2020/05/sample-mp4-file.mp4';
  String audioUrl =
      'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3';
  String countryAccent = 'Spanish';
  String description =
      'I am a reader who loves to read books and share my thoughts with others.';

  File? _selectedVideo;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nickname = widget.readerProfile?.profile?.nickname ?? nickname;
    genres = widget.readerProfile?.profile?.genre ?? genres;
    languages = widget.readerProfile?.profile?.language ?? languages;
    videoUrl = widget.readerProfile?.profile?.introductionVideoUrl ?? videoUrl;
    audioUrl = widget.readerProfile?.profile?.audioDescriptionUrl ?? audioUrl;
    countryAccent =
        widget.readerProfile?.profile?.countryAccent ?? countryAccent;
    description = widget.readerProfile?.profile?.description ?? description;
  }

  void _handleVideoSelection() async {
    final result = await ImagePicker().pickVideo(
      source: ImageSource.gallery,
    );

    if (result != null) {
      setState(() {
        _selectedVideo = File(result.path);
      });
    }
  }

  void _handleViewVideo() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
          child: VideoPlayerFromFile(
            videoFile: _selectedVideo!,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey[300]!,
                blurRadius: 5,
                spreadRadius: 2,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              ReaderEditField(
                title: 'Nick Name',
                value: nickname,
                onTap: () async {
                  EditUtils.showEditBottomSheet(context, "Nick name", nickname)
                      .then((value) => {
                            if (value != null)
                              {
                                setState(() {
                                  nickname = value['value'];
                                }),
                              }
                          });
                },
              ),
              Container(
                height: 1,
                width: double.infinity,
                color: Colors.grey[300],
              ),
              ReaderEditField(
                title: 'Genres',
                value: genres,
                onTap: () {
                  EditUtils.showEditBottomSheet(context, "Genres", genres)
                      .then((value) => {
                            if (value != null)
                              {
                                setState(() {
                                  genres = value['value'];
                                }),
                              }
                          });
                },
              ),
              Container(
                height: 1,
                width: double.infinity,
                color: Colors.grey[300],
              ),
              ReaderEditField(
                title: 'Languages',
                value: languages,
                onTap: () {
                  EditUtils.showEditBottomSheet(context, "Languages", languages)
                      .then((value) => {
                            if (value != null)
                              {
                                setState(() {
                                  languages = value['value'];
                                }),
                              }
                          });
                },
              ),
              Container(
                height: 1,
                width: double.infinity,
                color: Colors.grey[300],
              ),
              ReaderEditField(
                title: 'Country Accent',
                value: countryAccent,
                onTap: () {
                  EditUtils.showEditBottomSheet(
                          context, "Country Accent", countryAccent)
                      .then((value) => {
                            if (value != null)
                              {
                                setState(() {
                                  countryAccent = value['value'];
                                }),
                              }
                          });
                },
              ),
              Container(
                height: 1,
                width: double.infinity,
                color: Colors.grey[300],
              ),
              ReaderEditField(
                title: 'Description',
                value: description,
                onTap: () {
                  EditUtils.showEditBottomSheet(
                          context, "Description", description)
                      .then((value) => {
                            if (value != null)
                              {
                                setState(() {
                                  description = value['value'];
                                }),
                              }
                          });
                },
              ),
            ],
          ),
        ),
        Container(
          width: double.infinity,
          margin: const EdgeInsets.only(bottom: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              UploadButton(
                onTap: () {
                  EditUtils.showBottomSheetForUpload(context, () {});
                },
                iconColor: Colors.blue,
                title: 'Change Video',
              ),
              const SizedBox(width: 30),
              UploadButton(
                onTap: () {
                  EditUtils.showBottomSheetForUpload(context, () {});
                },
                iconColor: Colors.deepOrange,
                title: 'Change Audio',
              )
            ],
          ),
        ),
      ],
    );
  }
}
