import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class IntroVideo extends StatefulWidget {
  final String videoUrl;
  final Function()? pauseVideo;
  final double? width;

  const IntroVideo(
      {Key? key, required this.videoUrl, this.pauseVideo, this.width})
      : super(key: key);

  @override
  State<IntroVideo> createState() => IntroVideoState();
}

class IntroVideoState extends State<IntroVideo> {
  late ChewieController chewieController;

  void _initializeChewieController(String videoUrl) {
    chewieController = ChewieController(
      videoPlayerController:
          VideoPlayerController.networkUrl(Uri.parse(videoUrl)),
      autoInitialize: true,
      autoPlay: false,
      aspectRatio: widget.width == null ? 300 / 160 : widget.width! / 200,
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
    if (chewieController.videoPlayerController.value.isPlaying) {
      chewieController.pause();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initializeChewieController(widget.videoUrl);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    chewieController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.width == null
        ? Container(
            alignment: Alignment.topCenter,
            height: 160,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              child: Chewie(
                controller: chewieController,
              ),
            ),
          )
        : SizedBox(
            height: 200,
            child: Chewie(
              controller: chewieController,
            ),
          );
  }
}
