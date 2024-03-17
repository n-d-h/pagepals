import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pagepals/helpers/color_helper.dart';
import 'package:pagepals/helpers/space_helper.dart';
import 'package:pagepals/screens/screens_authorization/signin_screen/signin_intro/signin_home.dart';

class ForgotPasswordButton extends StatelessWidget {
  const ForgotPasswordButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: TextButton(
      onPressed: () {
        Navigator.of(context).push(
          PageTransition(
            child: const SigninHomeScreen(),
            type: PageTransitionType.bottomToTop,
            duration: const Duration(milliseconds: 300),
          ),
        );
      },
      child: Text(
        'Forgot password?',
        style: TextStyle(
            decoration: TextDecoration.underline,
            decorationColor: ColorHelper.getColor(ColorHelper.green),
            decorationThickness: 2,
            height: 2,
            fontSize: SpaceHelper.fontSize16,
            fontWeight: FontWeight.w600,
            color: ColorHelper.getColor(ColorHelper.green)),
      ),
    ));
  }
}
