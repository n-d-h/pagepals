import 'package:flutter/material.dart';
import 'package:pagepals/helpers/color_helper.dart';
import 'package:pagepals/helpers/space_helper.dart';
import 'package:pagepals/screens/reader_screen/reader_profile/reader_profile_review/comment_collection_widget.dart';

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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Sorted by",
                  style: TextStyle(
                    fontSize: SpaceHelper.fontSize18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: SpaceHelper.space8),
                TextButton(
                  onPressed: () {
                    showSortByBottomSheetModal(context);
                  },
                  child: Text(
                    'Filter',
                    style: TextStyle(
                      fontSize: SpaceHelper.fontSize14,
                      color: ColorHelper.getColor(ColorHelper.normal),
                    ),
                  ),
                ),
              ],
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

  void showSortByBottomSheetModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.9,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(SpaceHelper.space16),
          child: Column(
            children: [
              Text(
                'Sort by',
                style: TextStyle(
                  fontSize: SpaceHelper.fontSize18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: SpaceHelper.space16),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  leading: Icon(
                    Icons.check,
                    color: Colors.grey,
                    size: SpaceHelper.fontSize40,
                  ),
                  title: Text(
                    'Most relevant',
                    style: TextStyle(
                      fontSize: SpaceHelper.fontSize14,
                      color: ColorHelper.getColor(ColorHelper.normal),
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              SizedBox(height: SpaceHelper.space16),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  leading: Icon(
                    Icons.punch_clock,
                    color: Colors.grey,
                    size: SpaceHelper.fontSize40,
                  ),
                  title: Text(
                    'Most relevant',
                    style: TextStyle(
                      fontSize: SpaceHelper.fontSize14,
                      color: ColorHelper.getColor(ColorHelper.normal),
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              SizedBox(height: SpaceHelper.space16),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  leading: Icon(
                    Icons.thumb_up,
                    color: Colors.grey,
                    size: SpaceHelper.fontSize40,
                  ),
                  title: Text(
                    'Most relevant',
                    style: TextStyle(
                      fontSize: SpaceHelper.fontSize14,
                      color: ColorHelper.getColor(ColorHelper.normal),
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              SizedBox(height: SpaceHelper.space16),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  leading: Icon(
                    Icons.thumb_down,
                    color: Colors.grey,
                    size: SpaceHelper.fontSize40,
                  ),
                  title: Text(
                    'Most relevant',
                    style: TextStyle(
                      fontSize: SpaceHelper.fontSize14,
                      color: ColorHelper.getColor(ColorHelper.normal),
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
