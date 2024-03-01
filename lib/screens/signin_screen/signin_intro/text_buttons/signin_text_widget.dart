import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pagepals/helpers/color_helper.dart';
import 'package:pagepals/helpers/space_helper.dart';
import 'package:pagepals/screens/signin_screen/signin_main/signin_screen.dart';
import 'package:pagepals/screens/signup_screen/signup_screen.dart';

class SignInTextWidget extends StatefulWidget {
  final int opt;

  const SignInTextWidget({super.key, required this.opt});

  @override
  State<SignInTextWidget> createState() => _SignInTextWidgetState();
}

class _SignInTextWidgetState extends State<SignInTextWidget> {
  late Widget widgetOpt;
  late String widgetText;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    switch (widget.opt) {
      case 0:
        {
          widgetOpt = const SigninScreen();
          widgetText = 'Sign In';
        }
      case 1:
        {
          widgetOpt = const SignupScreen();
          widgetText = 'Sign Up';
        }
    }
    // widgetOpt = widget.opt;
    // widgetOpt == 0 ? widgetText = "Sign In" : widgetText
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.of(context).push(
          PageTransition(
            child: widgetOpt,
            type: PageTransitionType.bottomToTop,
            duration: const Duration(milliseconds: 400),
          ),
        );
      },
      child: Text(
        widgetText,
        style: TextStyle(
          fontSize: SpaceHelper.fontSize18,
          color: ColorHelper.getColor(ColorHelper.green),
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}
