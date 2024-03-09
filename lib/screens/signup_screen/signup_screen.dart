import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pagepals/helpers/color_helper.dart';
import 'package:pagepals/helpers/space_helper.dart';
import 'package:pagepals/screens/dash_board/dash_board_screen.dart';
import 'package:pagepals/screens/signin_screen/signin_main/signin_screen.dart';
import 'package:pagepals/screens/signup_screen/verify_code.dart';
import 'package:pagepals/screens/signup_screen/verify_email.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () {
          // Handle tap on screen to dismiss keyboard
          FocusScope.of(context).unfocus();
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              width: MediaQuery.of(context).size.width *
                  SpaceHelper.spaceNineTenths,
              margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Image(
                    image: AssetImage('assets/signin_logo.png'),
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: SpaceHelper.space8),
                  Text(
                    "Join PagePals",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: ColorHelper.getColor(ColorHelper.black),
                    ),
                  ),
                  const SizedBox(height: SpaceHelper.space8),
                  Text(
                    'Join our growing readers community to offer your professional '
                    'service, connect with customers, and get paid '
                    'to PagePals’ trusted platform.',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: SpaceHelper.fontSize16,
                      fontWeight: FontWeight.w300,
                      color: ColorHelper.getColor(ColorHelper.black),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: double.infinity, // <-- match_parent
                    height: 50,
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            PageTransition(
                                child: const DashBoardScreen(),
                                type: PageTransitionType.fade,
                                duration: const Duration(milliseconds: 300)),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor:
                              ColorHelper.getColor(ColorHelper.black),
                          backgroundColor:
                              ColorHelper.getColor(ColorHelper.gray),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                                flex: 3,
                                child: Image(
                                  image: AssetImage('assets/facebook.png'),
                                  fit: BoxFit.scaleDown,
                                )),
                            Expanded(
                              flex: 11,
                              child: Text(
                                'Continue with Facebook',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            )
                          ],
                        )),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: double.infinity, // <-- match_parent
                    height: 50,
                    child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          foregroundColor:
                              ColorHelper.getColor(ColorHelper.black),
                          backgroundColor:
                              ColorHelper.getColor(ColorHelper.gray),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                                flex: 3,
                                child: Image(
                                  image: AssetImage('assets/google.png'),
                                  fit: BoxFit.scaleDown,
                                )),
                            Expanded(
                              flex: 9,
                              child: Text(
                                'Continue with Google',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            )
                          ],
                        )),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: double.infinity, // <-- match_parent
                    height: 50,
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            PageTransition(
                                child: const VerifyEmailScreen(),
                                type: PageTransitionType.fade,
                                duration: const Duration(milliseconds: 300)),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor:
                              ColorHelper.getColor(ColorHelper.black),
                          backgroundColor:
                              ColorHelper.getColor(ColorHelper.gray),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Create PagePals account',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                          ),
                        )),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: RichText(
                      textAlign: TextAlign.center,
                      // Align the text inside RichText
                      text: TextSpan(
                        text: 'By Signing up, you agree to PagePals ',
                        style: TextStyle(
                          fontSize: SpaceHelper.fontSize14,
                          fontWeight: FontWeight.w400,
                          color: ColorHelper.getColor(ColorHelper.black),
                        ),
                        children: [
                          TextSpan(
                            text: 'Terms of Services ',
                            style: TextStyle(
                              fontSize: SpaceHelper.fontSize14,
                              fontWeight: FontWeight.w400,
                              color: ColorHelper.getColor(ColorHelper.green),
                            ),
                          ),
                          TextSpan(
                            text: '& ',
                            style: TextStyle(
                              fontSize: SpaceHelper.fontSize14,
                              fontWeight: FontWeight.w400,
                              color: ColorHelper.getColor(ColorHelper.black),
                            ),
                          ),
                          TextSpan(
                            text: 'Privacy Policy',
                            style: TextStyle(
                              fontSize: SpaceHelper.fontSize14,
                              fontWeight: FontWeight.w400,
                              color: ColorHelper.getColor(ColorHelper.green),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  // Center(
                  //   child: OutlinedButton(
                  //     onPressed: () {
                  //       Navigator.of(context).push(
                  //         PageTransition(
                  //           child: const SigninScreen(),
                  //           type: PageTransitionType.bottomToTop,
                  //           duration: const Duration(milliseconds: 300),
                  //         ),
                  //       );
                  //     },
                  //     style: OutlinedButton.styleFrom(
                  //       foregroundColor:
                  //           ColorHelper.getColor(ColorHelper.normal),
                  //       side: const BorderSide(
                  //         color: Colors.transparent,
                  //       ),
                  //     ),
                  //     child: Text(
                  //       'Sign in',
                  //       style: TextStyle(
                  //           fontSize: SpaceHelper.fontSize16,
                  //           fontWeight: FontWeight.w600,
                  //           color: ColorHelper.getColor(ColorHelper.green)),
                  //     ),
                  //   ),
                  // )

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            PageTransition(
                              child: const SigninScreen(),
                              type: PageTransitionType.bottomToTop,
                              duration: const Duration(milliseconds: 400),
                            ),
                          );
                        },
                        child: Text(
                          'Sign In',
                          style: TextStyle(
                            fontSize: SpaceHelper.fontSize18,
                            color: ColorHelper.getColor(ColorHelper.green),
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            PageTransition(
                              child: const DashBoardScreen(),
                              type: PageTransitionType.fade,
                              duration: const Duration(seconds: 1),
                            ),
                          );
                        },
                        child: Text(
                          'Skip',
                          style: TextStyle(
                            fontSize: SpaceHelper.fontSize18,
                            color: ColorHelper.getColor(ColorHelper.green),
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 23,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
