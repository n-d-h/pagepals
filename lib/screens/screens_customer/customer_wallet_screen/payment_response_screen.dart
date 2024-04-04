import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pagepals/helpers/color_helper.dart';
import 'package:pagepals/models/response_results_code.dart';
import 'package:pagepals/screens/screens_customer/menu_item/menu_item_screen.dart';

class PaymentResponseScreen extends StatelessWidget {
  final Map<String, String>? data;

  const PaymentResponseScreen({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    final resultCode = data!['resultCode'] ?? '';

    return Scaffold(
      body: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 70),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            resultCode == "0"
                ? SizedBox(
                    child: Column(
                      children: [
                        Image.asset('assets/booking_success.png'),
                        const SizedBox(height: 10),
                        Text(
                          ResponseResultCode.getMoMoResultCode(resultCode),
                          textAlign: TextAlign.center,
                          style: GoogleFonts.lexend(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            color: ColorHelper.getColor(ColorHelper.green),
                          ),
                        ),
                      ],
                    ),
                  )
                : SizedBox(
                    child: Column(
                      children: [
                        Image.asset('assets/error.png'),
                        const SizedBox(height: 10),
                        Text(
                          ResponseResultCode.getMoMoResultCode(resultCode),
                          textAlign: TextAlign.center,
                          style: GoogleFonts.lexend(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(10),
        child: OutlinedButton(
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
            foregroundColor: ColorHelper.getColor(ColorHelper.white),
            backgroundColor: ColorHelper.getColor(ColorHelper.green),
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
      ),
    );
  }
}
