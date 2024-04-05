import 'dart:convert';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pagepals/helpers/space_helper.dart';
import 'package:pagepals/models/authen_models/account_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomeWidget extends StatefulWidget {
  const WelcomeWidget({super.key});

  @override
  State<WelcomeWidget> createState() => _WelcomeWidgetState();
}

class _WelcomeWidgetState extends State<WelcomeWidget> {
  late String _displayName;

  @override
  void initState() {
    super.initState();
    _loadPrefs();
  }

  Future<void> _loadPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accountString = prefs.getString('account');
    if (accountString == null) {
      print('No account data found in SharedPreferences');
      return;
    }
    try {
      Map<String, dynamic> accountMap = json.decode(accountString);
      setState(() {
        _displayName =
            '@${AccountModel.fromJson(accountMap).fullName ?? 'anonymous'}';
      });
    } catch (e) {
      print('Error decoding account data: $e');
    }
  }

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
                      AppLocalizations.of(context)!.appDiscoveryNewBook,
                      duration: const Duration(milliseconds: 1200),
                      alignment: Alignment.centerLeft,
                      textStyle: GoogleFonts.lexend(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    RotateAnimatedText(
                      AppLocalizations.of(context)!.appReadAndLearn,
                      duration: const Duration(milliseconds: 1200),
                      alignment: Alignment.centerLeft,
                      textStyle: GoogleFonts.lexend(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    RotateAnimatedText(
                      AppLocalizations.of(context)!.appEnjoyYourTime,
                      duration: const Duration(milliseconds: 1200),
                      alignment: Alignment.centerLeft,
                      textStyle: GoogleFonts.lexend(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    RotateAnimatedText(
                      AppLocalizations.of(context)!.appGetInspired,
                      duration: const Duration(milliseconds: 1200),
                      alignment: Alignment.centerLeft,
                      textStyle: GoogleFonts.lexend(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    RotateAnimatedText(
                      AppLocalizations.of(context)!.appFindYourNextBook,
                      duration: const Duration(milliseconds: 1200),
                      alignment: Alignment.centerLeft,
                      textStyle: GoogleFonts.lexend(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    RotateAnimatedText(
                      AppLocalizations.of(context)!.appReadAndGrow,
                      // duration: const Duration(milliseconds: 2000),
                      alignment: Alignment.centerLeft,
                      textStyle: GoogleFonts.lexend(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
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
                text: AppLocalizations.of(context)!.appReviewUsNow,
                style: GoogleFonts.lexend(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.cyanAccent,
                ),
                children: [
                  TextSpan(
                    text: AppLocalizations.of(context)!.appTitle,
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
