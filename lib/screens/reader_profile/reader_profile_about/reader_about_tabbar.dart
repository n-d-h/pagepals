import 'package:flutter/material.dart';
import 'package:pagepals/helpers/space_helper.dart';
import 'package:pagepals/screens/reader_profile/reader_profile_about/video_player_screen.dart';

class ReaderAboutTabbar extends StatelessWidget {
  const ReaderAboutTabbar({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: ScrollController(),
      physics: const AlwaysScrollableScrollPhysics(),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        padding: const EdgeInsets.all(SpaceHelper.space16),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            VideoPlayerScreen(),
          ],
        ),
      )
    );
  }
}

