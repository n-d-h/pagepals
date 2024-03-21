import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pagepals/helpers/color_helper.dart';

// class DetailRow extends StatelessWidget {
//   final IconData icon;
//   final String text;
//
//   const DetailRow({super.key, required this.icon, required this.text});
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.start,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         Icon(
//           icon,
//           color: ColorHelper.getColor(ColorHelper.green),
//           size: 12,
//         ),
//         const SizedBox(width: 10),
//         Expanded(
//           child: Text(
//             text,
//             overflow: TextOverflow.clip,
//             style: GoogleFonts.lexend(
//               fontSize: 12,
//               fontWeight: FontWeight.w300,
//               color: Colors.black.withOpacity(0.6),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

class DetailRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const DetailRow({Key? key, required this.icon, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> parts = text.split(':');

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
              color: ColorHelper.getColor(ColorHelper.green), // Part 2: Rest of the text in green
            ),
          ),
        ),
      ],
    );
  }
}
