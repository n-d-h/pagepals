import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pagepals/helpers/color_helper.dart';

class CompletedBottom extends StatelessWidget {
  const CompletedBottom({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              backgroundColor: ColorHelper.getColor('#C6F4DE'),
              side: const BorderSide(color: Colors.transparent),
              fixedSize: const Size.fromWidth(148),
            ),
            child: Text(
              'Re-book',
              style: GoogleFonts.lexend(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: ColorHelper.getColor(ColorHelper.green),
              ),
            ),
          ),
          OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              backgroundColor: ColorHelper.getColor(ColorHelper.green),
              side: const BorderSide(color: Colors.transparent),
              fixedSize: const Size.fromWidth(148),
            ),
            child: Text(
              'Review',
              style: GoogleFonts.lexend(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
