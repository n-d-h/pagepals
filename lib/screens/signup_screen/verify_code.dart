import 'package:flutter/material.dart';
import 'package:flutter_verification_code_field/flutter_verification_code_field.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pagepals/helpers/color_helper.dart';
import 'package:pagepals/helpers/space_helper.dart';
import 'package:pagepals/screens/signup_screen/profile_screen.dart';

class VerifyCodeScreen extends StatefulWidget {
  final String email;

  const VerifyCodeScreen({super.key, required this.email});

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  late String userEmail;

  @override
  void initState() {
    super.initState();
    userEmail = widget.email;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          margin: const EdgeInsets.only(top: 70),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Verification Required',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w800,
                  // height: 0.7
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                'Please enter the 4 digit code sent to',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: ColorHelper.getColor('#7E7E7E')),
              ),
              Text(
                userEmail,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  // height: 3
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              VerificationCodeField(
                length: 4,
                // onFilled: (value) => print(value),
                size: const Size(50, 50),
                spaceBetween: 30,
                matchingPattern: RegExp(r'^\d+$'),
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Didn\'t receive a code? ',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: ColorHelper.getColor('#7E7E7E')),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Text(
                      'Resend Code ',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: ColorHelper.getColor(ColorHelper.green),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Change Email',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: Colors.black),
                  )),
              const SizedBox(
                height: 35,
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                width: double.infinity, // <-- match_parent
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      PageTransition(
                        child: ProfileScreen(email: userEmail),
                        type: PageTransitionType.rightToLeft,
                        duration: const Duration(milliseconds: 300),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: ColorHelper.getColor(ColorHelper.white),
                    backgroundColor: ColorHelper.getColor(ColorHelper.green),
                    padding: const EdgeInsets.symmetric(
                      horizontal: SpaceHelper.space16,
                      vertical: 9,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Continue',
                    style: TextStyle(
                      fontSize: SpaceHelper.fontSize16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
