import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:pagepals/helpers/color_helper.dart';
import 'package:video_player/video_player.dart';

// final tempVideoController = VideoPlayerController.networkUrl(Uri.parse(''));

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
      aspectRatio: widget.width / 200,
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
    // TODO: implement initState
    super.initState();
    _initializeChewieController(widget.videoUrl);
  }

  @override
  void dispose() {
    // TODO: implement dispose
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
      return SizedBox(
        height: 200,
        child: Chewie(
          controller: chewieController!,
        ),
      );
    } else {
      return Container(
        width: widget.width,
        height: 200,
        alignment: Alignment.center,
        color: Colors.grey[300],
        child: CircularProgressIndicator(
          color: ColorHelper.getColor(ColorHelper.green),
          strokeWidth: 3,
        ),
      );
    }
  }
}
