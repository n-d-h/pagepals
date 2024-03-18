import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pagepals/screens/screens_customer/reader_request/video_player_from_file.dart';
import 'package:video_player/video_player.dart';

class ReaderRequestStep3 extends StatefulWidget {
  const ReaderRequestStep3({super.key});

  @override
  State<ReaderRequestStep3> createState() => _ReaderRequestStep3State();
}

class _ReaderRequestStep3State extends State<ReaderRequestStep3> {
  String uploadedText = '';
  File? _selectedImage;
  File? _selectedVideo;

  void uploadText(String text) {
    setState(() {
      uploadedText = text;
    });
  }

  void _handleImageSelection() async {
    final result = await ImagePicker().pickImage(
      imageQuality: 70,
      maxWidth: 1440,
      maxHeight: 300,
      source: ImageSource.gallery,
    );

    if (result != null) {
      setState(() {
        _selectedImage = File(result.path);
      });
    }
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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Upload Image:',
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
                _selectedImage != null
                    ? Image.file(_selectedImage!)
                    : const Icon(
                        Icons.image,
                        size: 60.0,
                        color: Colors.grey,
                      ),
              ],
            ),
          ),
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: _handleImageSelection,
            child: const Text('Upload'),
          ),
          const SizedBox(height: 16.0),
          const Text(
            'AND',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16.0),
          const Text(
            'Upload your video introduction:',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16.0),
          Container(
            width: double.infinity,
            height: 400.0,
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
                    : const Icon(
                        Icons.video_collection,
                        size: 60.0,
                        color: Colors.grey,
                      ),
              ],
            ),
          ),
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: _handleVideoSelection,
            child: const Text('Upload'),
          ),
        ],
      ),
    );
  }
}

