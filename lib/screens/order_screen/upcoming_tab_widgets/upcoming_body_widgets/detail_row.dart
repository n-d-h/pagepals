import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pagepals/helpers/color_helper.dart';

class DetailRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const DetailRow({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: ColorHelper.getColor(ColorHelper.green),
          size: 12,
        ),
        const SizedBox(width: 10),
        Text(
          text,
          style: GoogleFonts.lexend(
            fontSize: 12,
            fontWeight: FontWeight.w300,
            color: Colors.black.withOpacity(0.6),
          ),
        )
      ],
    );
  }
}
