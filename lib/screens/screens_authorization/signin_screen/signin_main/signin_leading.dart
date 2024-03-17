import 'package:flutter/material.dart';
import 'package:pagepals/helpers/color_helper.dart';
import 'package:pagepals/helpers/space_helper.dart';

class SignInLeadingTexts extends StatelessWidget {
  const SignInLeadingTexts({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Image(
          image: AssetImage('assets/signin_logo.png'),
          fit: BoxFit.cover,
        ),
        const SizedBox(height: SpaceHelper.space8),
        Text(
          "Welcome back",
          textAlign: TextAlign.start,
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: ColorHelper.getColor(ColorHelper.black),
          ),
        ),
        const SizedBox(height: SpaceHelper.space8),
        Text(
          'Sign in to PagePals to pick up exactly where you left off.',
          textAlign: TextAlign.start,
          style: TextStyle(
            fontSize: SpaceHelper.fontSize16,
            fontWeight: FontWeight.w300,
            color: ColorHelper.getColor(ColorHelper.black),
          ),
        ),
        const SizedBox(
          height: 30,
        )
      ],
    );
  }
}
