import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pagepals/screens/screens_reader/reader_request/video_player_from_file.dart';
import 'package:pagepals/services/file_storage_service.dart';
import 'package:quickalert/quickalert.dart';

class ReaderRequestStep3 extends StatefulWidget {
  const ReaderRequestStep3({super.key});

  @override
  State<ReaderRequestStep3> createState() => _ReaderRequestStep3State();
}

class _ReaderRequestStep3State extends State<ReaderRequestStep3> {
  File? _selectedVideo;
  late String _downloadUrl;

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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Upload your video introduction:',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16.0),
          Container(
            width: double.infinity,
            height: 300.0,
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              border: Border.all(
                style: BorderStyle.solid,
                color: Colors.grey,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _selectedVideo != null
                    ? VideoPlayerFromFile(videoFile: _selectedVideo!)
                    : IconButton(
                        icon: const Icon(
                          Icons.video_collection,
                          size: 60.0,
                          color: Colors.grey,
                        ),
                        onPressed: _handleVideoSelection,
                      ),
              ],
            ),
          ),
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () async {
              _downloadUrl = await FileStorageService().uploadFile(_selectedVideo!);
              print('Download URL: $_downloadUrl');
              FileStorageService().saveVideoData(_downloadUrl);
              setState(() {
                _selectedVideo = null;
              });
              Future.delayed(const Duration(milliseconds: 300), () {
                QuickAlert.show(
                  context: context,
                  type: QuickAlertType.success,
                  title: 'Success Upload',
                  text: 'Reader request has been submitted successfully',
                  autoCloseDuration: const Duration(seconds: 3),
                );
              });
            },
            child: const Text('Upload'),
          ),
        ],
      ),
    );
  }
}
