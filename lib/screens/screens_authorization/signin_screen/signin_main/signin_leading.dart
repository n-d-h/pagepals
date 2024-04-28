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
        Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: const Image(
            image: AssetImage('assets/signin_logo.png'),
            fit: BoxFit.cover,
          ),
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
