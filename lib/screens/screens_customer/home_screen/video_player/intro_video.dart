import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:pagepals/helpers/color_helper.dart';
import 'package:video_player/video_player.dart';

class IntroVideo extends StatefulWidget {
  final String videoUrl;
  final Function()? pauseVideo;

  const IntroVideo({
    Key? key,
    required this.videoUrl,
    this.pauseVideo,
  }) : super(key: key);

  @override
  State<IntroVideo> createState() => IntroVideoState();
}

class IntroVideoState extends State<IntroVideo> {
  VideoPlayerController? videoPlayerController;
  ChewieController? chewieController;

  Future<void> onControllerChange() async {
    if (videoPlayerController == null) {
      _initializeChewieController(widget.videoUrl);
    } else {
      final oldController = videoPlayerController;
      await oldController!.dispose();
      _initializeChewieController(widget.videoUrl);
    }
  }

  void _initializeChewieController(String videoUrl) async {
    videoPlayerController =
        VideoPlayerController.networkUrl(Uri.parse(videoUrl));
    await videoPlayerController!.initialize();
    chewieController = ChewieController(
      videoPlayerController: videoPlayerController!,
      autoInitialize: true,
      autoPlay: false,
      aspectRatio: 300 / 160,
      showControlsOnInitialize: true,
      looping: false,
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
    setState(() {});
  }

  void pauseVideo() {
    if (chewieController != null) {
      if (chewieController!.videoPlayerController.value.isPlaying) {
        chewieController!.pause();
      }
    }
  }

  bool isChewieControllerVideoInitialized() {
    return chewieController != null
        ? chewieController!.videoPlayerController.value.isInitialized
        : false;
  }

  @override
  void initState() {
    super.initState();
    _initializeChewieController(widget.videoUrl);
  }

  @override
  void dispose() {
    super.dispose();
    if (chewieController != null) {
      chewieController!.dispose();
    }
    if (videoPlayerController != null) {
      videoPlayerController!.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isChewieControllerVideoInitialized()) {
      return Container(
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
            controller: chewieController!,
          ),
        ),
      );
    } else {
      return Container(
        width: 300,
        height: 160,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          ),
        ),
        alignment: Alignment.center,
        child: CircularProgressIndicator(
          color: ColorHelper.getColor(ColorHelper.green),
          strokeWidth: 3,
        ),
      );
    }
  }
}

