import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pagepals/helpers/color_helper.dart';
import 'package:pagepals/helpers/space_helper.dart';
import 'package:pagepals/models/authen_models/account_tokens.dart';
import 'package:pagepals/providers/google_signin_provider.dart';
import 'package:pagepals/screens/screens_customer/menu_item/menu_item_screen.dart';
import 'package:pagepals/services/authen_service.dart';
import 'package:quickalert/quickalert.dart';

class GoogleSignIn extends StatelessWidget {
  const GoogleSignIn({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: ElevatedButton(
          onPressed: () async {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return Center(
                  child: SizedBox(
                    height: 50,
                    width: 50,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(
                        ColorHelper.getColor(ColorHelper.green),
                      ),
                    ),
                  ),
                );
              },
            );
            // final SharedPreferences prefs =
            // await SharedPreferences.getInstance();
            final GoogleSignInProvider googleSignInProvider =
                GoogleSignInProvider();
            GoogleSignInAccount user = await googleSignInProvider.googleLogin();

            try {
              // Get Google ID token from Firebase user
              String? googleIdToken =
                  await FirebaseAuth.instance.currentUser!.getIdToken();

              AccountTokens? accountTokens =
                  await AuthenService.loginWithGoogle(googleIdToken!);
              // Handle successful login here
              if (accountTokens!.accessToken != null) {
                // Navigate to Dashboard screen on successful login
                Future.delayed(const Duration(seconds: 2), () {
                  Navigator.pop(context);
                  Navigator.of(context).pushAndRemoveUntil(
                    PageTransition(
                      child: const MenuItemScreen(),
                      type: PageTransitionType.bottomToTop,
                      duration: const Duration(milliseconds: 400),
                    ),
                    (route) => false,
                  );
                });
              }
            } catch (error) {
              // Show dialog with error message
              Future.delayed(const Duration(milliseconds: 100), () {
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
            foregroundColor: ColorHelper.getColor(ColorHelper.black),
            backgroundColor: ColorHelper.getColor(ColorHelper.gray),
            padding: const EdgeInsets.symmetric(
              horizontal: SpaceHelper.space24,
              vertical: 8,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Row(
            children: [
              Expanded(
                  flex: 1,
                  child: Image(
                    image: AssetImage('assets/google.png'),
                    fit: BoxFit.scaleDown,
                  )),
              SizedBox(
                width: SpaceHelper.space8,
              ),
              Expanded(
                flex: 2,
                child: Text(
                  'Google',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )
            ],
          )),
    );
  }
}
