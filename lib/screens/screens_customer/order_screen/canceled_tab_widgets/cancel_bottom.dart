import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pagepals/helpers/color_helper.dart';
import 'package:pagepals/models/booking_model.dart';

class CanceledBottom extends StatelessWidget {
  final Booking booking;
  final String? title;
  final Function()? onPressed;

  const CanceledBottom(
      {super.key, required this.booking, this.title, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: onPressed,
              style: OutlinedButton.styleFrom(
                backgroundColor: ColorHelper.getColor(ColorHelper.green),
                side: const BorderSide(color: Colors.transparent),
                fixedSize: const Size.fromWidth(double.infinity),
              ),
              child: Text(
                title ?? 'Re-book this Reader',
                style: GoogleFonts.lexend(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
