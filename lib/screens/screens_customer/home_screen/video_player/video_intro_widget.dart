import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:pagepals/helpers/color_helper.dart';
import 'package:video_player/video_player.dart';

class VideoIntroWidget extends StatefulWidget {
  const VideoIntroWidget({
    super.key,
    required this.videoUrl,
  });

  final String videoUrl;

  @override
  State<VideoIntroWidget> createState() => _VideoIntroWidgetState();
}

class _VideoIntroWidgetState extends State<VideoIntroWidget> {
  late VideoPlayerController videoPlayerController;
  late ChewieController chewieController;
  VideoPlayerController tempVideoController =
      VideoPlayerController.networkUrl(Uri.parse(''));

  void _initializeChewieController(String videoUrl) async {
    videoPlayerController =
        VideoPlayerController.networkUrl(Uri.parse(videoUrl));
    chewieController =
        ChewieController(videoPlayerController: tempVideoController);
    await videoPlayerController.initialize();
    tempVideoController = videoPlayerController;
    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      autoInitialize: true,
      autoPlay: false,
      showControlsOnInitialize: true,
      looping: false,
      placeholder: Container(
        color: Colors.white,
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
    if (chewieController.videoPlayerController.value.isPlaying) {
      chewieController.pause();
    }
  }

  void playVideo() {
    if (!chewieController.videoPlayerController.value.isPlaying) {
      chewieController.play();
    }
  }

  bool isChewieControllerVideoInitialized() {
    return chewieController.videoPlayerController.value.isInitialized;
  }

  @override
  void initState() {
    super.initState();
    _initializeChewieController(widget.videoUrl);
  }

  @override
  void dispose() {
    super.dispose();
    chewieController.dispose();
    videoPlayerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Video Intro'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: isChewieControllerVideoInitialized()
          ? Chewie(controller: chewieController)
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
