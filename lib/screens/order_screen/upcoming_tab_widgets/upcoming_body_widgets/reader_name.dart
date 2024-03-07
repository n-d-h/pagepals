import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ReaderName extends StatelessWidget {
  final String nickname;
  final String username;

  const ReaderName({super.key, required this.nickname, required this.username});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 19,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            nickname,
            style: GoogleFonts.lexend(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          const SizedBox(width: 5),
          Text(
            username,
            style: GoogleFonts.lexend(
              fontSize: 9,
              fontWeight: FontWeight.w300,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }
}
