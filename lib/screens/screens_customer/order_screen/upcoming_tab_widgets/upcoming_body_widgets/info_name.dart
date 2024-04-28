import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InfoName extends StatelessWidget {
  final String nickname;
  final String username;

  const InfoName({Key? key, required this.nickname, required this.username}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        bool overflow = constraints.maxWidth < (nickname.length * 16 + username.length * 9 + 5);

        return SizedBox(
          height: 19,
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Flexible(
                child: Text(
                  nickname,
                  overflow: overflow ? TextOverflow.ellipsis : TextOverflow.clip,
                  style: GoogleFonts.lexend(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(width: 5),
              Flexible(
                child: Text(
                  username,
                  overflow: overflow ? TextOverflow.ellipsis : TextOverflow.clip,
                  style: GoogleFonts.lexend(
                    fontSize: 9,
                    fontWeight: FontWeight.w300,
                    color: Colors.grey.shade600,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
