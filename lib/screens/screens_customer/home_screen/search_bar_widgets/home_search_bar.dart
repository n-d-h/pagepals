import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pagepals/screens/screens_customer/menu_item/menu_item_screen.dart';
import 'package:pagepals/screens/screens_customer/search_screen/search_screen.dart';
import 'package:unicons/unicons.dart';

class HomeSearchBar extends StatelessWidget {
  const HomeSearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(24, 24, 24, 0),
      child: Theme(
        data: ThemeData(
          splashFactory: NoSplash.splashFactory,
        ),
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(
              PageTransition(
                type: PageTransitionType.fade,
                child: const MenuItemScreen(index: 2),
                duration: const Duration(milliseconds: 300),
              ),
            );
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.grey.shade300,
                width: 0.3,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Row(
              children: [
                const Icon(
                  UniconsLine.search,
                  color: Colors.grey,
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: AnimatedTextKit(
                    onTap: () {
                      Navigator.of(context).push(
                        PageTransition(
                          type: PageTransitionType.fade,
                          child: const MenuItemScreen(index: 2),
                          duration: const Duration(milliseconds: 300),
                        ),
                      );
                    },
                    repeatForever: true,
                    animatedTexts: [
                      TyperAnimatedText(
                        AppLocalizations.of(context)!.appSearchSomething,
                        textStyle: const TextStyle(
                          color: Colors.green,
                          // fontSize: 16,
                        ),
                        speed: const Duration(milliseconds: 60),
                      ),
                      TyperAnimatedText(
                        AppLocalizations.of(context)!.appBookAreNowAtYourFinger,
                        textStyle: const TextStyle(
                          color: Colors.deepOrange,
                          // fontSize: 16,
                        ),
                        speed: const Duration(milliseconds: 60),
                      ),
                      TypewriterAnimatedText(
                        AppLocalizations.of(context)!.appReaderAreWaitingForYou,
                        textStyle: const TextStyle(
                          color: Colors.blueAccent,
                          // fontSize: 16,
                        ),
                        speed: const Duration(milliseconds: 60),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
