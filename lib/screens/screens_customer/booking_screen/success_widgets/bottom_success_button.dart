import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pagepals/helpers/color_helper.dart';
import 'package:pagepals/helpers/space_helper.dart';
import 'package:pagepals/screens/screens_customer/menu_item/menu_item_screen.dart';

class SuccessBottomButton extends StatelessWidget {
  const SuccessBottomButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20),
        ),
        color: Colors.white,
        // Adjust background color
        boxShadow: [
          BoxShadow(color: Colors.black12, spreadRadius: 2, blurRadius: 3),
        ],
      ),
      child: Center(
        child: Container(
          margin: const EdgeInsets.fromLTRB(30, 10, 30, 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              OutlinedButton(
                onPressed: () {},
                // Disable button if not enabled
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.transparent),
                  foregroundColor: ColorHelper.getColor(ColorHelper.white),
                  backgroundColor: ColorHelper.getColor(ColorHelper.green),
                  padding: const EdgeInsets.symmetric(
                    horizontal: SpaceHelper.space16,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'View appointment',
                      style: GoogleFonts.lexend(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              OutlinedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    PageTransition(
                      child: const MenuItemScreen(),
                      type: PageTransitionType.rightToLeft,
                      duration: const Duration(milliseconds: 300),
                    ),
                  );
                },
                // Disable button if not enabled
                style: OutlinedButton.styleFrom(
                  splashFactory: NoSplash.splashFactory,
                  side: const BorderSide(color: Colors.transparent),
                  foregroundColor: ColorHelper.getColor(ColorHelper.green),
                  backgroundColor:
                  ColorHelper.getColor(ColorHelper.transparent),
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Go to Home',
                      style: GoogleFonts.lexend(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
