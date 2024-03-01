import 'package:flutter/material.dart';
import 'package:pagepals/helpers/color_helper.dart';

class SignInIntroText extends StatelessWidget {
  const SignInIntroText({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(32, 0, 32, 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            textAlign: TextAlign.start,
            // Align the text inside RichText
            text: TextSpan(
              text: 'pagepals',
              style: TextStyle(
                fontSize: 37,
                fontWeight: FontWeight.w900,
                color: ColorHelper.getColor(ColorHelper.white),
              ),
              children: [
                TextSpan(
                  text: '.',
                  style: TextStyle(
                    fontSize: 42,
                    fontWeight: FontWeight.bold,
                    color: ColorHelper.getColor(ColorHelper.green),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'Reading Services. On\nDemand',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w500,
              color: ColorHelper.getColor(ColorHelper.white),
            ),
          )
        ],
      ),
    );
  }
}
