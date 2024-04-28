import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pagepals/helpers/space_helper.dart';
import 'package:pagepals/models/reader_models/reader_profile_model.dart';
import 'package:pagepals/screens/screens_customer/reader_screen/reader_profile/reader_profile_about/reader_info_line.dart';
import 'package:pagepals/screens/screens_customer/reader_screen/reader_profile/reader_profile_about/video_player_screen.dart';
import 'package:unicons/unicons.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ReaderAboutTabbar extends StatelessWidget {
  final String videoUrl;
  final ReaderProfile? reader;

  const ReaderAboutTabbar({super.key, required this.videoUrl, this.reader});

  @override
  Widget build(BuildContext context) {
    GlobalKey<VideoPlayerScreenState> videoPlayerKey =
        GlobalKey<VideoPlayerScreenState>();
    String createTime = reader?.profile?.createdAt ?? '';
    DateTime createDateTime;
    try {
      createDateTime = DateTime.parse(createTime);
    } catch (e) {
      // Handle the error, such as setting a default value or logging the error.
      createDateTime = DateTime.now(); // Set a default value
      print('Error parsing date: $e');
    }
    String formattedDate = DateFormat('MMM d, yyyy').format(createDateTime);
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
                reader?.profile?.description ??
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
            ReaderInfoLine(
              iconData: UniconsLine.language,
              title: 'Language',
              content: reader?.profile?.language ?? 'N/A',
            ),
            ReaderInfoLine(
              iconData: UniconsLine.user_circle,
              title: 'Member since',
              content: formattedDate,
            ),
            ReaderInfoLine(
              iconData: UniconsLine.notes,
              title: 'Genre',
              content: reader?.profile?.genre ?? 'Horror',
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
            ReaderInfoLine(
              iconData: UniconsLine.selfie,
              title: 'gender',
              content: reader?.profile?.account?.customer?.gender ?? 'N/A',
            ),
            ReaderInfoLine(
              iconData: UniconsLine.globe,
              title: 'Accent',
              content: reader?.profile?.countryAccent ?? 'N/A',
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
