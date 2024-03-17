import 'package:flutter/material.dart';
import 'package:pagepals/helpers/color_helper.dart';

class RatingLine extends StatelessWidget {
  final String detail;
  final int rating;
  final double? fontSize;
  final double? ratingIconSize;

  const RatingLine({super.key,
    required this.detail,
    required this.rating,
    this.ratingIconSize,
    this.fontSize,});


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            detail,
            style: TextStyle(
              color: Colors.grey,
              fontSize: fontSize ?? 12,
            ),
          ),
          Row(
            children: [
              Icon(
                Icons.star_rounded,
                color: ColorHelper.getColor('#FFA800'),
                size: ratingIconSize ?? 16,
              ),
              Container(
                margin: const EdgeInsets.only(left: 2),
                child: Text(
                  '$rating.0',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: fontSize ?? 12,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
