import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends StatefulWidget {
  const VideoPlayerScreen({
    super.key,
  });

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  final videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(
      'https://firebasestorage.googleapis.com/v0/b/authen-6cf1b.appspot.com/o/videos%2F2024-03-19%2022%3A10%3A21.900394.mp4?alt=media&token=d49c14d4-c677-4674-b0a5-32d4fa1c2043'));

  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    _chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      autoInitialize: true,
      looping: true,
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

  @override
  void dispose() {
    videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * 0.9;
    final aspectRatio = width / 200;

    return SizedBox(
      width: width,
      height: 200,
      child: AspectRatio(
        aspectRatio: aspectRatio,
        child: Chewie(
          controller: _chewieController,
        ),
      ),
    );
  }
}
