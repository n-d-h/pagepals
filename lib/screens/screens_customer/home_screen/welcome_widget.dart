import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pagepals/helpers/space_helper.dart';

class WelcomeWidget extends StatelessWidget {
  const WelcomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * SpaceHelper.spaceNineTenths,
      margin: const EdgeInsets.symmetric(
        horizontal: SpaceHelper.space24,
        vertical: SpaceHelper.space24,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(SpaceHelper.space16),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.blue.withOpacity(0.8),
            Colors.purple.withOpacity(0.8),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: SpaceHelper.space8,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(SpaceHelper.space24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
            height: 84,
              child: DefaultTextStyle(
                style: GoogleFonts.lexend(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                child: AnimatedTextKit(
                  animatedTexts: [
                    RotateAnimatedText(
                      'Discover new books!',
                      duration: const Duration(milliseconds: 1200),
                      alignment: Alignment.centerLeft,
                    ),
                    RotateAnimatedText(
                      'Read and learn!',
                      duration: const Duration(milliseconds: 1200),
                      alignment: Alignment.centerLeft,
                    ),
                    RotateAnimatedText(
                      'Enjoy your time!',
                      duration: const Duration(milliseconds: 1200),
                      alignment: Alignment.centerLeft,
                    ),
                    RotateAnimatedText(
                      'Get inspired!',
                      duration: const Duration(milliseconds: 1200),
                      alignment: Alignment.centerLeft,
                    ),
                    RotateAnimatedText(
                      'Find your next book!',
                      duration: const Duration(milliseconds: 1200),
                      alignment: Alignment.centerLeft,
                    ),
                    RotateAnimatedText(
                      'Read and grow!',
                      // duration: const Duration(milliseconds: 2000),
                      alignment: Alignment.centerLeft,
                    ),
                  ],
                  pause: const Duration(milliseconds: 300),
                  repeatForever: true,
                  onTap: () {
                    print("Ad Banner tapped!");
                  },
                ),
              ),
            ),
            const SizedBox(height: SpaceHelper.space12),
            RichText(
              text: TextSpan(
                text: 'Review us now, ',
                style: GoogleFonts.lexend(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.cyanAccent,
                ),
                children: [
                  TextSpan(
                    text: FirebaseAuth.instance.currentUser?.displayName,
                    style: GoogleFonts.lexend(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.yellow,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
