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
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;
  bool _isVideoError = false;
  bool _isInitializing = true;

  @override
  void initState() {
    super.initState();
    _initializeVideoPlayer();
  }

  @override
  void dispose() {
    _chewieController.dispose();
    _videoPlayerController.dispose();
    super.dispose();
  }

  Future<void> _initializeVideoPlayer() async {
    setState(() {
      _isInitializing = true;
      _videoPlayerController = VideoPlayerController.file(widget.videoFile);
      _chewieController = ChewieController(
          videoPlayerController:
              VideoPlayerController.networkUrl(Uri.parse('')));
    });

    try {
      await _videoPlayerController.initialize();

      setState(() {
        _chewieController = ChewieController(
          videoPlayerController: _videoPlayerController,
          autoPlay: false,
          aspectRatio: _videoPlayerController.value.aspectRatio,
          errorBuilder: (context, errorMessage) {
            setState(() {
              _isVideoError = true;
              _isInitializing = false;
            });
            return Center(
              child: Text(
                'Error: $errorMessage',
                style: const TextStyle(color: Colors.white),
              ),
            );
          },
        );
        _isInitializing = false;
      });
    } catch (e) {
      print('Error initializing video player: $e');
      setState(() {
        _isVideoError = true;
        _isInitializing = false;
        _reinitializeControllers();
      });
    }

    // Listen for playback errors
    _videoPlayerController.addListener(_handlePlaybackError);
  }

  void _handlePlaybackError() {
    if (_videoPlayerController.value.hasError) {
      print('Playback error: ${_videoPlayerController.value.errorDescription}');
      setState(() {
        _isVideoError = true;
      });

      // Attempt to reinitialize the controllers
      _reinitializeControllers();
    }
  }

  void _reinitializeControllers() async {
    // Dispose the current controllers
    _chewieController.dispose();
    _videoPlayerController.dispose();

    // Attempt to initialize new controllers
    await _initializeVideoPlayer();
    setState(() {
      _isInitializing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // if (_isVideoError) {
    //   _reinitializeControllers();
    // }
    return _isInitializing
        ? Center(
            child: CircularProgressIndicator(),
          )
        : _isVideoError
            ? Center(
                child: Text(
                  'Video playback is not supported on this device.',
                  style: TextStyle(color: Colors.red),
                ),
              )
            : SizedBox(
                height: 500,
                child: Chewie(
                  controller: _chewieController,
                ),
              );
  }
}
