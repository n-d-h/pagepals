import 'package:flutter/material.dart';
import 'package:pagepals/helpers/color_helper.dart';
import 'package:pagepals/models/comment_model.dart';

class ProfileReviewBox extends StatelessWidget {
  final CommentModel? comment;

  const ProfileReviewBox({super.key, this.comment});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (BuildContext context, int index) {
          if (comment == null || comment!.list!.isEmpty) {
            return const SizedBox();
          }
          CommentItem commentItem = comment?.list![index] ?? CommentItem();
          return Container(
            width: 300,
            margin: const EdgeInsets.fromLTRB(2, 10, 25, 10),
            padding: const EdgeInsets.symmetric(
              horizontal: 0,
              vertical: 15,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black45,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                )
              ],
            ),
            child: InkWell(
              onTap: () {},
              child: Stack(
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(
                                left: 16,
                                right: 8,
                              ),
                              width: 35,
                              height: 35,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: NetworkImage(
                                    commentItem.customer?.imageUrl ??
                                        'https://via.placeholder.com/150',
                                  ),
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                            ),
                            Text(
                              commentItem.customer?.fullName ?? 'Anonymous',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 3,
                          ),
                          child: Text(
                            commentItem.review ?? 'No comment',
                            textAlign: TextAlign.start,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              height: 2.2,
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomCenter,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.star_rounded,
                              color: ColorHelper.getColor('#FFA800'),
                              size: 16,
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 2),
                              child: Text(
                                '${commentItem.rating ?? 0.0}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          commentItem.date ?? DateTime.now().toString(),
                          style: const TextStyle(
                            color: Colors.black54,
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
