import 'package:flutter/material.dart';
import 'package:pagepals/screens/screens_customer/home_screen/popular_readers_widgets/popular_reader_widget.dart';
import 'package:pagepals/screens/screens_customer/home_screen/video_player/intro_video.dart';

class ProfileReaderCollection extends StatelessWidget {
  final GlobalKey<IntroVideoState> introVideoKey;

  const ProfileReaderCollection({super.key, required this.introVideoKey});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      decoration: const BoxDecoration(color: Colors.white),
      padding: const EdgeInsets.fromLTRB(25, 1, 25, 10),
      // margin: const EdgeInsets.only(bottom: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 20, bottom: 10),
            child: const Text(
              'People also view',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          const PopularReaderWidget(),
        ],
      ),
    );
  }
}
