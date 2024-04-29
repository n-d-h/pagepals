import 'package:flutter/material.dart';
import 'package:pagepals/helpers/color_helper.dart';
import 'package:pagepals/helpers/space_helper.dart';
import 'package:pagepals/screens/screens_authorization/signin_screen/signin_intro/box_buttons/signin_box_buttons.dart';
import 'package:pagepals/screens/screens_authorization/signin_screen/signin_intro/signin_intro_text.dart';
import 'package:pagepals/screens/screens_authorization/signin_screen/signin_intro/text_buttons/signin_text_buttons.dart';

class SigninHomeScreen extends StatefulWidget {
  const SigninHomeScreen({super.key});

  @override
  State<SigninHomeScreen> createState() => _SigninHomeScreenState();
}

class _SigninHomeScreenState extends State<SigninHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: ColorHelper.getColor(ColorHelper.grayActive),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        controller: ScrollController(),
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SignInIntroText(),
              Container(
                width: double.infinity,
                height: 300,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  margin: const EdgeInsets.symmetric(
                    horizontal: SpaceHelper.space24,
                    vertical: SpaceHelper.space24,
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SignInBoxButtons(),
                      SignInTextButtons(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
