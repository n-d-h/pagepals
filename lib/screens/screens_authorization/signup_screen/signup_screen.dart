import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pagepals/helpers/color_helper.dart';
import 'package:pagepals/helpers/space_helper.dart';
import 'package:pagepals/models/authen_models/account_tokens.dart';
import 'package:pagepals/providers/google_signin_provider.dart';
import 'package:pagepals/screens/screens_authorization/signin_screen/signin_main/signin_screen.dart';
import 'package:pagepals/screens/screens_authorization/signup_screen/verify_email.dart';
import 'package:pagepals/screens/screens_customer/menu_item/menu_item_screen.dart';
import 'package:pagepals/services/authen_service.dart';
import 'package:pagepals/services/firebase_message_service.dart';
import 'package:quickalert/quickalert.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: true,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Column(
                children: const [
                  Text(
                    'Back',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                    ),
                  ),
                  Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Container(
            alignment: Alignment.topCenter,
            width: MediaQuery.of(context).size.width *
                SpaceHelper.spaceNineTenths,
            margin: const EdgeInsets.fromLTRB(20, 5, 20, 0),
            child: SingleChildScrollView(
              controller: ScrollController(),
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
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
                                child: const MenuItemScreen(),
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
                        onPressed: () async {
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return Center(
                                child:
                                    LoadingAnimationWidget.staggeredDotsWave(
                                  color: Colors.greenAccent,
                                  size: 60,
                                ),
                              );
                            },
                          );
                          final GoogleSignInProvider googleSignInProvider =
                              GoogleSignInProvider();
                          GoogleSignInAccount user =
                              await googleSignInProvider.googleLogin();

                          try {
                            // Get Google ID token from Firebase user
                            String? googleIdToken = await FirebaseAuth
                                .instance.currentUser!
                                .getIdToken();

                            AccountTokens? accountTokens =
                                await AuthenService.loginWithGoogle(
                                    googleIdToken!);

                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            String? fcmToken = prefs.getString('fcmToken');

                            if (fcmToken == null) {
                              FirebaseMessageService firebaseMessageService =
                                  FirebaseMessageService();
                              await firebaseMessageService.initialize();
                              fcmToken =
                                  await firebaseMessageService.getFCMToken();
                              prefs.setString('fcmToken', fcmToken!);
                            }

                            // Handle successful login here
                            if (accountTokens!.accessToken != null) {
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              String fcmToken =
                                  prefs.getString('fcmToken') ?? '';
                              String accountId =
                                  accountTokens.accountId ?? '';
                              await AuthenService.updateFcmToken(
                                  fcmToken, accountId, false);

                              // Navigate to Dashboard screen on successful login
                              Future.delayed(const Duration(seconds: 2), () {
                                Navigator.pop(context);
                                Navigator.of(context).push(
                                  PageTransition(
                                    child: const MenuItemScreen(),
                                    type: PageTransitionType.bottomToTop,
                                    duration:
                                        const Duration(milliseconds: 400),
                                  ),
                                );
                              });
                            }
                          } catch (error) {
                            await googleSignInProvider.googleSignIn.signOut();
                            // Show dialog with error message
                            Future.delayed(const Duration(milliseconds: 100),
                                () {
                              Navigator.pop(context);
                              QuickAlert.show(
                                context: context,
                                type: QuickAlertType.error,
                                title: 'Login Failed',
                                text: 'Google account not available',
                              );
                            });
                          }
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
                ],
              ),
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            margin: const EdgeInsets.fromLTRB(20, 0, 20, 80),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
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
                // TextButton(
                //   onPressed: () {
                //     Navigator.of(context).push(
                //       PageTransition(
                //         child: const MenuItemScreen(),
                //         type: PageTransitionType.fade,
                //         duration: const Duration(seconds: 1),
                //       ),
                //     );
                //   },
                //   child: Text(
                //     'Skip',
                //     style: TextStyle(
                //       fontSize: SpaceHelper.fontSize18,
                //       color: ColorHelper.getColor(ColorHelper.green),
                //       fontWeight: FontWeight.w800,
                //     ),
                //   ),
                // ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
