import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pagepals/helpers/color_helper.dart';
import 'package:pagepals/helpers/space_helper.dart';
import 'package:pagepals/screens/signin_screen/signin_screen.dart';
import 'package:pagepals/screens/signup_screen/signup_screen.dart';

class SigninHomeScreen extends StatefulWidget {
  const SigninHomeScreen({super.key});

  @override
  State<SigninHomeScreen> createState() => _SigninHomeScreenState();
}

class _SigninHomeScreenState extends State<SigninHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorHelper.getColor(ColorHelper.grayActive),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
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
                const SizedBox(height: 10,),
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
          ),
          Container(
            width: double.infinity,
            height: 290,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 140,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Material(
                                borderRadius:
                                    BorderRadius.circular(SpaceHelper.space16),
                                color: Colors.white,
                                elevation: 8,
                                shadowColor: Colors.black87,
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(
                                      SpaceHelper.space16),
                                  onTap: () {},
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 100,
                                        child: Material(
                                          borderRadius: BorderRadius.circular(
                                              SpaceHelper.space16),
                                          clipBehavior: Clip.antiAlias,
                                          child: const Image(
                                            image: AssetImage(
                                                'assets/signin_home.png'),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      const Text(
                                        'Find a Service',
                                        style: TextStyle(
                                          fontSize: SpaceHelper.fontSize16,
                                          fontWeight: FontWeight.bold,
                                          height: 2.5,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: Material(
                                borderRadius:
                                    BorderRadius.circular(SpaceHelper.space16),
                                color: Colors.white,
                                elevation: 8,
                                shadowColor: Colors.black87,
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(
                                      SpaceHelper.space16),
                                  onTap: () {},
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 100,
                                        child: Material(
                                          borderRadius: BorderRadius.circular(
                                              SpaceHelper.space16),
                                          clipBehavior: Clip.antiAlias,
                                          child: const Image(
                                            image: AssetImage(
                                                'assets/signin_home.png'),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      const Text(
                                        'Become a Reader',
                                        style: TextStyle(
                                          fontSize: SpaceHelper.fontSize16,
                                          fontWeight: FontWeight.bold,
                                          height: 2.5,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 290 - 140 - 24 * 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      // Align at the bottom
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
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
                                  color:
                                      ColorHelper.getColor(ColorHelper.green),
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  PageTransition(
                                    child: const SignupScreen(),
                                    type: PageTransitionType.bottomToTop,
                                    duration: const Duration(milliseconds: 400),
                                  ),
                                );
                              },
                              child: Text(
                                'Sign Up',
                                style: TextStyle(
                                  fontSize: SpaceHelper.fontSize18,
                                  color:
                                      ColorHelper.getColor(ColorHelper.green),
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
