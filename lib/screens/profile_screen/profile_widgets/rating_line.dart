import 'package:flutter/material.dart';
import 'package:pagepals/helpers/color_helper.dart';

class RatingLine extends StatelessWidget {
  final String detail;
  final int rating;

  const RatingLine({Key? key, required this.detail, required this.rating})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            detail,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),
          Row(
            children: [
              Icon(
                Icons.star_rounded,
                color: ColorHelper.getColor('#FFA800'),
                size: 16,
              ),
              Container(
                margin: const EdgeInsets.only(left: 2),
                child: Text(
                  '$rating.0',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
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
