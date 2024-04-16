import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pagepals/models/reader_models/reader_profile_model.dart';
import 'package:pagepals/models/reader_models/reader_update_model.dart';
import 'package:pagepals/providers/reader_update_provider.dart';
import 'package:pagepals/screens/screens_reader/reader_profile/edit_utils.dart';
import 'package:pagepals/screens/screens_reader/reader_profile/reader_edit_field.dart';
import 'package:pagepals/screens/screens_reader/reader_profile/reader_edit_profile_screen.dart';
import 'package:pagepals/screens/screens_reader/reader_profile/upload_button.dart';
import 'package:pagepals/screens/screens_reader/reader_request/audio_player_from_file.dart';
import 'package:pagepals/screens/screens_reader/reader_request/video_player_from_file.dart';
import 'package:provider/provider.dart';

class ReaderColumnEditField extends StatefulWidget {
  final ReaderProfile? readerProfile;
  final ReaderUpdate? readerUpdate;

  const ReaderColumnEditField(
      {super.key, this.readerProfile, this.readerUpdate});

  @override
  State<ReaderColumnEditField> createState() => _ReaderColumnEditFieldState();
}

class _ReaderColumnEditFieldState extends State<ReaderColumnEditField> {
  late String nickname;
  late String genres;
  late String languages;
  late String videoUrl;
  late String audioUrl;
  late String countryAccent;
  late String description;

  File? _selectedVideo;
  File? _selectedAudio;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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

  void _handleVideoSelection(ReaderUpdateProvider update) async {
    final result = await ImagePicker().pickVideo(
      source: ImageSource.gallery,
    );

    if (result != null) {
      setState(() {
        _selectedVideo = File(result.path);
        update.updateReaderUpdateModel(
            introductionVideoUrl: _selectedVideo!.path);
      });
    }
  }

  void _handleViewVideo() async {
    if (_selectedVideo != null) {
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
  }

  void _handleAudioSelection(ReaderUpdateProvider update) async {
    final XFile? result = await ImagePicker().pickVideo(
      source: ImageSource.gallery,
    );

    String extension = result?.path.split('.').last ?? '';
    if (extension != 'mp3') {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            surfaceTintColor: Colors.white,
            title: const Text('Error'),
            content: const Text('Audio must be in MP3 format'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
      return;
    } else {
      if (result != null) {
        setState(() {
          _selectedAudio = File(result.path);
          update.updateReaderUpdateModel(
              audioDescriptionUrl: _selectedAudio!.path);
        });
      }
    }
  }

  void _handleViewAudio() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            height: 200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.close),
                ),
                Center(
                  child: AudioPlayerFromFile(
                    audioFile: _selectedAudio!,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final readerUpdateProvider = context.read<ReaderUpdateProvider>();
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
                                  readerUpdateProvider.updateReaderUpdateModel(
                                      nickname: nickname);
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
                                readerUpdateProvider.updateReaderUpdateModel(
                                    genres: genres),
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
                                readerUpdateProvider.updateReaderUpdateModel(
                                    languages: languages),
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
                                readerUpdateProvider.updateReaderUpdateModel(
                                    countryAccent: countryAccent),
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
                                readerUpdateProvider.updateReaderUpdateModel(
                                    description: description),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UploadButton(
                onTap: () {
                  _selectedVideo != null
                      ? _handleViewVideo()
                      : _handleVideoSelection(readerUpdateProvider);
                },
                icon: Icon(
                  _selectedVideo != null
                      ? Icons.play_circle_fill
                      : Icons.cloud_upload,
                  size: 50,
                  color: Colors.blueAccent,
                ),
                title: _selectedVideo != null ? 'View Video' : 'Change Video',
                onCanceled: _selectedVideo != null
                    ? () {
                        setState(() {
                          _selectedVideo = null;
                          readerUpdateProvider
                              .clearField('introductionVideoUrl');
                          Navigator.of(context).pushAndRemoveUntil(
                            PageTransition(
                              child: ReaderEditProfileScreen(
                                readerUpdate: readerUpdateProvider.readerUpdate,
                                readerProfile: widget.readerProfile,
                              ),
                              type: PageTransitionType.fade,
                              duration: const Duration(milliseconds: 300),
                            ),
                            (route) => false,
                          );
                        });
                      }
                    : null,
              ),
              const SizedBox(width: 30),
              UploadButton(
                onTap: () {
                  _selectedAudio != null
                      ? _handleViewAudio()
                      : _handleAudioSelection(readerUpdateProvider);
                },
                icon: Icon(
                  _selectedAudio != null
                      ? Icons.play_circle_fill
                      : Icons.cloud_upload,
                  size: 50,
                  color: Colors.deepOrange,
                ),
                title: _selectedAudio != null
                    ? 'View Audio'
                    : 'Change Audio',
                onCanceled: _selectedAudio != null
                    ? () {
                        setState(() {
                          _selectedAudio = null;
                          readerUpdateProvider.clearField('audioDescriptionUrl');
                          Navigator.of(context).pushAndRemoveUntil(
                            PageTransition(
                              child: ReaderEditProfileScreen(
                                readerUpdate: readerUpdateProvider.readerUpdate,
                                readerProfile: widget.readerProfile,
                              ),
                              type: PageTransitionType.fade,
                              duration: const Duration(milliseconds: 300),
                            ),
                            (route) => false,
                          );
                        });
                      }
                    : null,
              )
            ],
          ),
        ),
      ],
    );
  }
}
