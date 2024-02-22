import 'package:flutter/material.dart';
import 'package:pagepals/helpers/space_helper.dart';
import 'package:pagepals/screens/reader_screen/reader_profile/reader_profile_about/video_player_screen.dart';

class ReaderAboutTabbar extends StatelessWidget {
  const ReaderAboutTabbar({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: ScrollController(),
      physics: const AlwaysScrollableScrollPhysics(),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        padding: const EdgeInsets.all(SpaceHelper.space8),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            VideoPlayerScreen(),
            SizedBox(height: SpaceHelper.space16),
            Padding(
              padding: EdgeInsets.all(5.0),
              child: Text(
                'Reader Introduction',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: SpaceHelper.space12),
            Padding(
              padding: EdgeInsets.all(5.0),
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
                ),
              ),
            ),
            SizedBox(height: SpaceHelper.space12),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.location_on),
                SizedBox(width: SpaceHelper.space8),
                Text(
                  'Ho Chi Minh City, Viet Nam',
                  style: TextStyle(
                    fontSize: 13,
                  ),
                ),
              ],
            ),
            SizedBox(height: SpaceHelper.space12),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.cake),
                SizedBox(width: SpaceHelper.space8),
                Text('June 10, 1999')
              ],
            ),
            SizedBox(height: SpaceHelper.space12),
            Padding(
              padding: EdgeInsets.all(5.0),
              child: Text(
                'Languages',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: SpaceHelper.space12),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.language),
                SizedBox(width: SpaceHelper.space8),
                Text('Vietnamese, English')
              ],
            ),
          ],
        ),
      ),
    );
  }
}
