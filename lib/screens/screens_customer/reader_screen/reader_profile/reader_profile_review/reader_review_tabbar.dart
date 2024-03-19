import 'package:flutter/material.dart';
import 'package:pagepals/helpers/color_helper.dart';
import 'package:pagepals/helpers/space_helper.dart';
import 'package:pagepals/screens/screens_customer/profile_screen/profile_widgets/rating_line.dart';
import 'package:pagepals/screens/screens_customer/reader_screen/reader_profile/reader_profile_review/comment_collection_widget.dart';

class ReaderReviewTabbar extends StatefulWidget {
  const ReaderReviewTabbar({super.key});

  @override
  State<ReaderReviewTabbar> createState() => _ReaderReviewTabbarState();
}

class _ReaderReviewTabbarState extends State<ReaderReviewTabbar> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      controller: ScrollController(),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        padding: const EdgeInsets.all(SpaceHelper.space16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: const Text(
                "Overall Rating",
                style: TextStyle(
                  fontSize: SpaceHelper.fontSize18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: SpaceHelper.space8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.star_rounded,
                    color: ColorHelper.getColor('#FFA800')),
                Icon(Icons.star_rounded,
                    color: ColorHelper.getColor('#FFA800')),
                Icon(Icons.star_rounded,
                    color: ColorHelper.getColor('#FFA800')),
                Icon(Icons.star_rounded,
                    color: ColorHelper.getColor('#FFA800')),
                Icon(Icons.star_rounded,
                    color: ColorHelper.getColor('#FFA800')),
                const SizedBox(width: SpaceHelper.space8),
                const Text(
                  '5.0',
                  style: TextStyle(
                    fontSize: SpaceHelper.fontSize16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: SpaceHelper.space16),
            const RatingLine(
              detail: 'Reader communication level',
              rating: 5,
              fontSize: 16,
              ratingIconSize: 25,
            ),
            const SizedBox(height: SpaceHelper.space8),
            const RatingLine(
              detail: 'Reader communication level',
              rating: 5,
              fontSize: 16,
              ratingIconSize: 25,
            ),
            const SizedBox(height: SpaceHelper.space8),
            const RatingLine(
              detail: 'Reader communication level',
              rating: 5,
              fontSize: 16,
              ratingIconSize: 25,
            ),
            const SizedBox(height: SpaceHelper.space8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Sorted by",
                  style: TextStyle(
                    fontSize: SpaceHelper.fontSize18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: SpaceHelper.space8),
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
            const SizedBox(height: SpaceHelper.space16),
            const CommentCollectionWidget(
              text:
                  'I am very satisfied with the service of this reader. I have learned a lot from her. I will continue to use her service in the future.sakfjdhlddldldldldldldldldldldldldldldldldldldldldldldldldldldldldldldldldldldldldldldldldl ádlkfhjffjfjfjfjfjfjfjfjfjfjfjfjfjfjfjfjfjfjfjfjfjfjfjfjfjfjfjfjfjfjfjfjfjfjfjf',
            ),
            const CommentCollectionWidget(
              text:
                  'I am very satisfied with the service of this reader. I have learned a lot from her. I will continue to use her service in the future.',
            ),
            const CommentCollectionWidget(
              text:
                  'I am very satisfied with the service of this reader. I have learned a lot from her. I will continue to use her service in the future.',
            ),
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
              const Text(
                'Sort by',
                style: TextStyle(
                  fontSize: SpaceHelper.fontSize18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: SpaceHelper.space16),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  leading: const Icon(
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
              const SizedBox(height: SpaceHelper.space16),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  leading: const Icon(
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
              const SizedBox(height: SpaceHelper.space16),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  leading: const Icon(
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
              const SizedBox(height: SpaceHelper.space16),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  leading: const Icon(
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
