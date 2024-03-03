import 'package:flutter/material.dart';
import 'package:pagepals/helpers/color_helper.dart';

class BookingBadge extends StatelessWidget {
  final String title;
  const BookingBadge({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 5, 0, 7),
      padding: const EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 15
      ),
      // height: 20,
      // width: 200,
      decoration: BoxDecoration(
        color: ColorHelper.getColor("#D9E9E7"),
        borderRadius: const BorderRadius.all(Radius.circular(10))
      ),
      child: Text(
        title,
        style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: ColorHelper.getColor('#1DBF73')
        ),
      ),
    );
  }
}
