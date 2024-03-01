import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pagepals/helpers/color_helper.dart';
import 'package:pagepals/screens/dash_board/dash_board_screen.dart';
import 'package:pagepals/screens/signin_screen/signin_intro/signin_home.dart';
import 'package:pagepals/screens/signin_screen/signin_main/signin_screen.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    setupPageTransition();
  }

  setupPageTransition() async {
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.push(
        context,
        PageTransition(
          type: PageTransitionType.fade,
          child: const SigninHomeScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "PAGEPALS.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.w900,
                color: ColorHelper.getColor(ColorHelper.normal),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
