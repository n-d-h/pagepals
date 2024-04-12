import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:pagepals/helpers/color_helper.dart';
import 'package:video_player/video_player.dart';

final tempVideoController = VideoPlayerController.networkUrl(Uri.parse(''));

class VideoPlayerScreen extends StatefulWidget {
  final double width;
  final String videoUrl;

  const VideoPlayerScreen({
    super.key,
    required this.width,
    required this.videoUrl,
  });

  @override
  State<VideoPlayerScreen> createState() => VideoPlayerScreenState();
}

class VideoPlayerScreenState extends State<VideoPlayerScreen> {
  // final videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(
  //     'https://firebasestorage.googleapis.com/v0/b/authen-6cf1b.appspot.com/o/videos%2F2024-03-19%2022%3A10%3A21.900394.mp4?alt=media&token=d49c14d4-c677-4674-b0a5-32d4fa1c2043'));

  late VideoPlayerController videoPlayerController;
  ChewieController _chewieController =
      ChewieController(videoPlayerController: tempVideoController);

  @override
  void initState() {
    super.initState();
    videoPlayerController = VideoPlayerController.networkUrl(
      Uri.parse(
        widget.videoUrl,
      ),
    );
    videoPlayerController.initialize().then((_) {
      setState(() {
        _chewieController = ChewieController(
          videoPlayerController: videoPlayerController,
          autoInitialize: true,
          looping: true,
          aspectRatio: widget.width / 200,
          placeholder: Container(
            color: Colors.grey[300]!,
            child: Center(
              child: CircularProgressIndicator(
                color: ColorHelper.getColor(ColorHelper.green),
                strokeWidth: 3,
              ),
            ),
          ),
          errorBuilder: (context, errorMessage) {
            return Center(
              child: Text(
                errorMessage,
                style: const TextStyle(color: Colors.white),
              ),
            );
          },
        );
      });
    });
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  // Check if ChewieController is initialized
  bool isChewieControllerInitialized() {
    return _chewieController.videoPlayerController.value.isInitialized;
  }

  @override
  Widget build(BuildContext context) {
    return !isChewieControllerInitialized()
        ? Container(
            height: 200,
            width: widget.width,
            color: Colors.grey[300]!,
            child: Center(
              child: CircularProgressIndicator(
                color: ColorHelper.getColor(ColorHelper.green),
                strokeWidth: 3,
              ),
            ),
          )
        : SizedBox(
            width: widget.width,
            height: 200,
            child: Chewie(
              controller: _chewieController,
            ),
          );
  }
}
