import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pagepals/helpers/color_helper.dart';
import 'package:pagepals/models/comment_model.dart';
import 'package:pagepals/models/reader_models/reader_profile_model.dart';
import 'package:pagepals/screens/screens_customer/profile_screen/profile_widgets/rating_line.dart';
import 'package:pagepals/screens/screens_customer/profile_screen/profile_widgets/review_widgets/review_box.dart';

class ProfileReviewWidget extends StatelessWidget {
  final ReaderProfile? reader;
  final CommentModel? comment;

  const ProfileReviewWidget({super.key, this.reader, this.comment});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 410,
      decoration: const BoxDecoration(color: Colors.white),
      padding: const EdgeInsets.fromLTRB(25, 1, 0, 10),
      margin: const EdgeInsets.only(bottom: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Generate filled star icons
                for (int i = 0; i < (reader?.profile?.rating ?? 0); i++)
                  Icon(
                    Icons.star_rounded,
                    color: ColorHelper.getColor('#FFA800'),
                    size: 23,
                  ),
                // Generate unfilled star icons
                for (int i = (reader?.profile?.rating ?? 0); i < 5; i++)
                  Icon(
                    Icons.star_outline_rounded,
                    color: ColorHelper.getColor('#FFA800'),
                    size: 23,
                  ),
                Container(
                  margin: const EdgeInsets.only(left: 5),
                  child: Text(
                    '${reader?.profile?.rating ?? '0'}.0',
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(right: 25),
            child: Column(
              children: [
                RatingLine(
                  detail: 'Reader community level',
                  rating: reader?.profile?.rating ?? 0,
                ),
                RatingLine(
                  detail: 'Clear and easy to understand explanation',
                  rating: reader?.profile?.rating ?? 0,
                ),
                RatingLine(
                  detail: 'Service as described',
                  rating: reader?.profile?.rating ?? 0,
                ),
              ],
            ),
          ),
          Visibility(
            visible: (reader?.profile?.totalOfReviews ?? 0) > 0,
            child: Container(
              margin: const EdgeInsets.only(top: 7, bottom: 7, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${reader?.profile?.totalOfReviews ?? 0} reviews',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'See All',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: ColorHelper.getColor(ColorHelper.green),
                        fontSize: 14,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          ProfileReviewBox(comment: comment),
        ],
      ),
    );
  }
}
