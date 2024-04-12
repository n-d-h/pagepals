import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pagepals/screens/screens_reader/reader_request/audio_player_from_file.dart';
import 'package:pagepals/screens/screens_reader/reader_request/video_player_from_file.dart';
import 'package:unicons/unicons.dart';

class ReaderRequestStep3 extends StatefulWidget {
  final Function(dynamic value) videoUploadCallback;
  final Function(dynamic value) imageUploadCallback;
  final Function(dynamic value) audioUploadCallback;

  const ReaderRequestStep3({
    super.key,
    required this.videoUploadCallback,
    required this.imageUploadCallback,
    required this.audioUploadCallback,
  });


  @override
  State<ReaderRequestStep3> createState() => _ReaderRequestStep3State();
}

class _ReaderRequestStep3State extends State<ReaderRequestStep3> {
  File? _selectedVideo;
  File? _selectedImage;
  File? _selectedAudio;

  void _handleVideoSelection() async {
    final result = await ImagePicker().pickVideo(
      source: ImageSource.gallery,
    );

    if (result != null) {
      setState(() {
        _selectedVideo = File(result.path);
      });
      widget.videoUploadCallback(result.path);
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

  void _handleImageSelection() async {
    final result = await ImagePicker().pickImage(
      imageQuality: 70,
      maxWidth: 1440,
      maxHeight: 1440,
      source: ImageSource.gallery,
    );

    if (result != null) {
      setState(() {
        _selectedImage = File(result.path);
      });
      widget.imageUploadCallback(result.path);
    }
  }

  void _handleViewImage() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Image.file(
            _selectedImage!,
          ),
        );
      },
    );
  }

  void _handleAudioSelection() async {
    final result = await ImagePicker().pickVideo(
      source: ImageSource.gallery,
    );

    if (result != null) {
      setState(() {
        _selectedAudio = File(result.path);
      });
      widget.audioUploadCallback(result.path);
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
            borderRadius: BorderRadius.circular(0),
          ),
          child: Container(
            height: 200,
            child: AudioPlayerFromFile(
              audioFile: _selectedAudio!,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Upload video:',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16.0),
          Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  border: Border.all(
                    style: BorderStyle.solid,
                    color: Colors.grey,
                  ),
                ),
                child: ClipRect(
                  child: _selectedVideo != null
                      ? InkWell(
                          onTap: _handleViewVideo,
                          child: const Icon(
                            Icons.play_arrow,
                            size: 60.0,
                            color: Colors.grey,
                          ),
                        )
                      : const Icon(
                          Icons.video_collection,
                          size: 30.0,
                          color: Colors.grey,
                        ),
                ),
              ),
              const SizedBox(width: 16.0),
              InkWell(
                onTap: _handleVideoSelection,
                child: const Icon(
                  UniconsLine.plus_circle,
                  size: 30.0,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          const Text(
            'After uploading the video, you can click the play button to preview the video',
            style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.normal,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 16.0),
          const Text(
            'Upload image:',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16.0),
          Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  border: Border.all(
                    style: BorderStyle.solid,
                    color: Colors.grey,
                  ),
                ),
                child: ClipRect(
                  child: _selectedImage != null
                      ? InkWell(
                          onTap: _handleViewImage,
                          child: Image.file(
                            _selectedImage!,
                            fit: BoxFit.cover,
                          ),
                        )
                      : const Icon(
                          Icons.image,
                          size: 30.0,
                          color: Colors.grey,
                        ),
                ),
              ),
              const SizedBox(width: 16.0),
              InkWell(
                onTap: _handleImageSelection,
                child: const Icon(
                  UniconsLine.plus_circle,
                  size: 30.0,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          const Text(
            'After uploading the image, you can click the image to preview the image',
            style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.normal,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 16.0),
          const Text(
            'Upload audio:',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16.0),
          Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  border: Border.all(
                    style: BorderStyle.solid,
                    color: Colors.grey,
                  ),
                ),
                child: ClipRect(
                  child: _selectedAudio != null
                      ? InkWell(
                          onTap: _handleViewAudio,
                          child: const Icon(
                            Icons.play_arrow,
                            size: 60.0,
                            color: Colors.grey,
                          ),
                        )
                      : const Icon(
                          Icons.audio_file,
                          size: 30.0,
                          color: Colors.grey,
                        ),
                ),
              ),
              const SizedBox(width: 16.0),
              InkWell(
                onTap: _handleAudioSelection,
                child: const Icon(
                  UniconsLine.plus_circle,
                  size: 30.0,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          const Text(
            'Must be in MP3 format',
            style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.normal,
              color: Colors.red,
            ),
          ),
          const Text(
            'After uploading the audo, you can click the image to preview the image',
            style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.normal,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 16.0),
          // ElevatedButton(
          //   onPressed: () async {
          //     _downloadUrl =
          //         await FileStorageService().uploadFile(_selectedVideo!);
          //     print('Download URL: $_downloadUrl');
          //     FileStorageService().saveVideoData(_downloadUrl);
          //     setState(() {
          //       _selectedVideo = null;
          //     });
          //     Future.delayed(const Duration(milliseconds: 300), () {
          //       QuickAlert.show(
          //         context: context,
          //         type: QuickAlertType.success,
          //         title: 'Success Upload',
          //         text: 'Reader request has been submitted successfully',
          //         autoCloseDuration: const Duration(seconds: 3),
          //       );
          //     });
          //   },
          //   child: const Text('Upload'),
          // ),
        ],
      ),
    );
  }
}
