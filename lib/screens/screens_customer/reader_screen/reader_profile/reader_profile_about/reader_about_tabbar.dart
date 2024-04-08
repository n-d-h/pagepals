import 'package:flutter/material.dart';
import 'package:pagepals/helpers/space_helper.dart';
import 'package:pagepals/screens/screens_customer/reader_screen/reader_profile/reader_profile_about/reader_info_line.dart';
import 'package:pagepals/screens/screens_customer/reader_screen/reader_profile/reader_profile_about/video_player_screen.dart';
import 'package:unicons/unicons.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ReaderAboutTabbar extends StatelessWidget {
  final String videoUrl;
  const ReaderAboutTabbar({super.key, required this.videoUrl});

  @override
  Widget build(BuildContext context) {
    GlobalKey<VideoPlayerScreenState> videoPlayerKey =
        GlobalKey<VideoPlayerScreenState>();
    return SingleChildScrollView(
      // controller: ScrollController(),
      // physics: const AlwaysScrollableScrollPhysics(),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        padding: const EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 15,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 25,
              ),
              child: Text(
                AppLocalizations.of(context)!.appVideIntroduction,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            VideoPlayerScreen(
              key: videoPlayerKey,
              videoUrl: videoUrl,
              width: MediaQuery.of(context).size.width - 30,
            ),
            const SizedBox(height: SpaceHelper.space16),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                AppLocalizations.of(context)!.appReaderIntroduction,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: SpaceHelper.space12),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 5, 7),
              child: Text(
                'My name is Minh, I’m 22 years old and I’m currently live '
                'in Ho Chi Minh City, Viet Nam \n\n'
                'I really love reading book, my hobby is sipping a cup of tea, '
                'sit in my garden '
                'under the morning sunshine and reading book, I also love to '
                'wrap my read '
                'book to protect it from dust and  keep it new. I always try '
                'to deep learning a book so I hope that  '
                'I can share what I have learned from book to you! \n\nAnd I’d '
                'love to meet you too! :) ',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.black.withOpacity(0.6),
                ),
              ),
            ),
            const SizedBox(height: SpaceHelper.space12),
            const ReaderInfoLine(
              iconData: UniconsLine.map_marker,
              title: 'From',
              content: 'Ho Chi Minh city, Vietnam',
            ),
            const ReaderInfoLine(
              iconData: UniconsLine.user_circle,
              title: 'Member since',
              content: 'March 14, 2023',
            ),
            const ReaderInfoLine(
              iconData: UniconsLine.notes,
              title: 'Genre',
              content: 'Horror',
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Text(
                AppLocalizations.of(context)!.appLanguages,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: SpaceHelper.space12),
            const ReaderInfoLine(
              iconData: UniconsLine.selfie,
              title: 'gender',
              content: 'Male',
            ),
            const ReaderInfoLine(
              iconData: UniconsLine.globe,
              title: 'Accent',
              content: 'Northern Spanish',
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
