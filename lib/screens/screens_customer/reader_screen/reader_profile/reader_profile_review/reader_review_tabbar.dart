import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pagepals/helpers/color_helper.dart';
import 'package:pagepals/helpers/space_helper.dart';
import 'package:pagepals/models/comment_model.dart';
import 'package:pagepals/screens/screens_customer/profile_screen/profile_widgets/rating_line.dart';
import 'package:pagepals/screens/screens_customer/reader_screen/reader_profile/reader_profile_review/comment_collection_widget.dart';

class ReaderReviewTabbar extends StatefulWidget {
  final CommentModel? commentModel;

  const ReaderReviewTabbar({super.key, this.commentModel});

  @override
  State<ReaderReviewTabbar> createState() => _ReaderReviewTabbarState();
}

class _ReaderReviewTabbarState extends State<ReaderReviewTabbar> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
              ],
            ),
            widget.commentModel == null
                ? SizedBox(
                    height: 100,
                    child: Center(
                      child: LoadingAnimationWidget.staggeredDotsWave(
                        color: ColorHelper.getColor(ColorHelper.green),
                        size: 60,
                      ),
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: widget.commentModel!.list!.length,
                    itemBuilder: (context, index) {
                      final comment = widget.commentModel!.list![index];
                      return CommentCollectionItem(
                        comment: comment,
                      );
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
