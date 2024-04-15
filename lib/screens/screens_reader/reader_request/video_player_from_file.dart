import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerFromFile extends StatefulWidget {
  final File videoFile;

  const VideoPlayerFromFile({Key? key, required this.videoFile})
      : super(key: key);

  @override
  State<VideoPlayerFromFile> createState() => _VideoPlayerFromFileState();
}

class _VideoPlayerFromFileState extends State<VideoPlayerFromFile> {
  late ChewieController _chewieController;

  void _initializeChewieController(File videoFile) {
    _chewieController = ChewieController(
      videoPlayerController: VideoPlayerController.file(videoFile),
      autoInitialize: true,
      autoPlay: false,
      aspectRatio: 300 / 500,
      showControlsOnInitialize: false,
      looping: false,
      errorBuilder: (context, errorMessage) {
        return Center(
          child: Text(
            errorMessage,
            style: const TextStyle(color: Colors.white),
          ),
        );
      },
    );
  }

  void pauseVideo() {
    if (_chewieController.videoPlayerController.value.isPlaying) {
      _chewieController.pause();
    }
  }

  @override
  void initState() {
    super.initState();
    _initializeChewieController(widget.videoFile);
  }

  @override
  void dispose() {
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      child: Chewie(
        controller: _chewieController,
      ),
    );
  }
}
