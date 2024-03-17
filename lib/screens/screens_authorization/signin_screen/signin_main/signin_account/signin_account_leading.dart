import 'package:flutter/material.dart';
import 'package:pagepals/helpers/color_helper.dart';
import 'package:pagepals/helpers/space_helper.dart';

class SignInAccLeadingText extends StatelessWidget {
  const SignInAccLeadingText({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: RichText(
      text: TextSpan(
          text: 'or sign in with ',
          style: TextStyle(
            fontSize: SpaceHelper.fontSize16,
            fontWeight: FontWeight.w600,
            color: ColorHelper.getColor(ColorHelper.black),
          ),
          children: [
            TextSpan(
              text: ' PagePals  ',
              style: TextStyle(
                fontSize: SpaceHelper.fontSize16,
                fontWeight: FontWeight.w600,
                color: ColorHelper.getColor(ColorHelper.green),
              ),
            ),
            TextSpan(
              text: 'account',
              style: TextStyle(
                fontSize: SpaceHelper.fontSize16,
                fontWeight: FontWeight.w600,
                color: ColorHelper.getColor(ColorHelper.black),
              ),
            )
          ]),
    ));
  }
}
