import 'package:flutter/material.dart';
import 'package:pagepals/helpers/color_helper.dart';

class RatingRow extends StatelessWidget {
  final int? rating;
  final String reviews;

  const RatingRow({super.key, required this.rating, required this.reviews});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 7),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 23,
            padding: const EdgeInsets.only(right: 12),
            decoration: const BoxDecoration(
                border:
                    Border(right: BorderSide(width: 2, color: Colors.black12))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.star_rounded,
                  color: ColorHelper.getColor('#FFA800'),
                  size: 20,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 2),
                  child: Text(
                    '${rating ?? '0'}.0/5.0',
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
              padding: const EdgeInsets.only(left: 12),
              // decoration: const BoxDecoration(
              //     border:
              //     Border(left: BorderSide(width: 2, color: Colors.black12))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '$reviews reviews',
                    style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        color: Colors.black),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
