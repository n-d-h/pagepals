import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pagepals/helpers/color_helper.dart';

class DetailRow extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color? color;

  const DetailRow(
      {Key? key, required this.icon, required this.text, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> parts = text.split(':');

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: color ?? ColorHelper.getColor(ColorHelper.green),
          size: 12,
        ),
        const SizedBox(width: 10),
        Text(
          '${parts[0]}:', // Part 1: "Service:"
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.lexend(
            fontSize: 12,
            fontWeight: FontWeight.w300,
            color: Colors.black.withOpacity(0.6),
          ),
        ),
        const SizedBox(width: 4), // Adjust as needed
        Expanded(
          child: Text(
            parts.length > 1 ? parts[1] : '',
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.lexend(
              fontSize: 12,
              fontWeight: FontWeight.w300,
              color: color ??
                  ColorHelper.getColor(
                    ColorHelper.green,
                  ), // Part 2: Rest of the text in green
            ),
          ),
        ),
      ],
    );
  }
}
