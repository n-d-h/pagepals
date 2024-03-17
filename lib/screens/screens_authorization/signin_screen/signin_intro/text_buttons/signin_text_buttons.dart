import 'package:flutter/material.dart';
import 'package:pagepals/screens/screens_authorization/signin_screen/signin_intro/text_buttons/signin_text_widget.dart';

class SignInTextButtons extends StatelessWidget {
  const SignInTextButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 290 - 140 - 24 * 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        // Align at the bottom
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SignInTextWidget(opt: 0),
              SignInTextWidget(opt: 1),
            ],
          ),
        ],
      ),
    );
  }
}
