import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:pagepals/helpers/color_helper.dart';
import 'package:pagepals/screens/screens_customer/reader_screen/reader_profile/reader_profile_about/video_player_screen.dart';
import 'package:video_player/video_player.dart';

class IntroVideo extends StatefulWidget {
  final String videoUrl;
  final Function()? pauseVideo;
  final double? width;

  const IntroVideo({
    Key? key,
    required this.videoUrl,
    this.pauseVideo,
    this.width,
  }) : super(key: key);

  @override
  State<IntroVideo> createState() => IntroVideoState();
}

class IntroVideoState extends State<IntroVideo> {
  VideoPlayerController tempVideoController = VideoPlayerController.networkUrl(Uri.parse(''));
  late VideoPlayerController videoPlayerController;
  late ChewieController chewieController;

  void _initializeChewieController(String videoUrl) async{
    videoPlayerController =
        VideoPlayerController.networkUrl(Uri.parse(videoUrl));
    chewieController = ChewieController(videoPlayerController: tempVideoController);
    await videoPlayerController.initialize();
    tempVideoController = videoPlayerController;
    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      autoInitialize: true,
      autoPlay: false,
      aspectRatio: widget.width == null ? 300 / 160 : widget.width! / 200,
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
    if (chewieController.videoPlayerController.value.isPlaying) {
      chewieController.pause();
    }
  }

  void playVideo() {
    if (!chewieController.videoPlayerController.value.isPlaying) {
      chewieController.play();
    }
  }

  // Check if ChewieController is initialized
  bool isChewieControllerVideoInitialized() {
    return chewieController.videoPlayerController.value.isInitialized;
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
    videoPlayerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isChewieControllerVideoInitialized()) {
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
    } else {
      return widget.width == null
          ? Container(
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
            )
          : Container(
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
