import 'package:flutter/material.dart';
import 'package:pagepals/helpers/space_helper.dart';
import 'package:pagepals/screens/reader_profile/reader_profile_review/comment_collection_widget.dart';

class ReaderReviewTabbar extends StatefulWidget {
  const ReaderReviewTabbar({super.key});

  @override
  State<ReaderReviewTabbar> createState() => _ReaderReviewTabbarState();
}

class _ReaderReviewTabbarState extends State<ReaderReviewTabbar> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      controller: ScrollController(),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        padding: const EdgeInsets.all(SpaceHelper.space16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Overall Rating",
              style: TextStyle(
                fontSize: SpaceHelper.fontSize18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: SpaceHelper.space16),
            Row(
              children: [
                Icon(Icons.star, color: Colors.orange),
                Icon(Icons.star, color: Colors.orange),
                Icon(Icons.star, color: Colors.orange),
                Icon(Icons.star, color: Colors.orange),
                Icon(Icons.star, color: Colors.orange),
                SizedBox(width: SpaceHelper.space8),
                Text(
                  '5.0',
                  style: TextStyle(
                    fontSize: SpaceHelper.fontSize16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: SpaceHelper.space16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Reader communitation level',
                  style: TextStyle(
                    fontSize: SpaceHelper.fontSize16,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(width: SpaceHelper.space8),
                Row(children: [
                  Text(
                    '5.0',
                    style: TextStyle(
                      fontSize: SpaceHelper.fontSize14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(Icons.star, color: Colors.orange),
                ]),
              ],
            ),
            SizedBox(height: SpaceHelper.space16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Reader communitation level',
                  style: TextStyle(
                    fontSize: SpaceHelper.fontSize16,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(width: SpaceHelper.space8),
                Row(children: [
                  Text(
                    '5.0',
                    style: TextStyle(
                      fontSize: SpaceHelper.fontSize14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(Icons.star, color: Colors.orange),
                ]),
              ],
            ),
            SizedBox(height: SpaceHelper.space16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Reader communitation level',
                  style: TextStyle(
                    fontSize: SpaceHelper.fontSize16,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(width: SpaceHelper.space8),
                Row(children: [
                  Text(
                    '5.0',
                    style: TextStyle(
                      fontSize: SpaceHelper.fontSize14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(Icons.star, color: Colors.orange),
                ]),
              ],
            ),
            SizedBox(height: SpaceHelper.space16),
            Text(
              "Sorted by",
              style: TextStyle(
                fontSize: SpaceHelper.fontSize18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: SpaceHelper.space16),
            CommentCollectionWidget(),
            CommentCollectionWidget(),
            CommentCollectionWidget(),
          ],
        ),
      ),
    );
  }
}
