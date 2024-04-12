import 'package:flutter/material.dart';
import 'package:flutter_verification_code_field/flutter_verification_code_field.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pagepals/helpers/color_helper.dart';
import 'package:pagepals/helpers/space_helper.dart';
import 'package:pagepals/screens/screens_authorization/signup_screen/profile_screen.dart';
import 'package:pagepals/screens/screens_authorization/signup_screen/verify_email.dart';
import 'package:pagepals/services/authen_service.dart';
import 'package:quickalert/quickalert.dart';
import 'dart:async';

class VerifyCodeScreen extends StatefulWidget {
  final String email;
  final String otp;

  const VerifyCodeScreen({Key? key, required this.email, required this.otp})
      : super(key: key);

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  late String userEmail;
  late String otp;
  String otpInput = '';
  bool isResendButtonDisabled = false;
  int countdownSeconds = 30;
  late Timer? _timer;

  @override
  void initState() {
    super.initState();
    userEmail = widget.email;
    otp = widget.otp;
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        controller: ScrollController(),
        child: Container(
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
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                'Please enter the 6 digits code sent to',
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
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              VerificationCodeField(
                length: 6,
                onFilled: (value) {
                  setState(() {
                    otpInput = value;
                  });
                },
                size: const Size(40, 60),
                spaceBetween: 15,
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
                    onTap: isResendButtonDisabled
                        ? null
                        : () async {
                            setState(() {
                              isResendButtonDisabled = true;
                              countdownSeconds = 30; // Reset the countdown timer
                            });

                            // Start countdown timer
                            _timer = Timer.periodic(const Duration(seconds: 1),
                                (timer) {
                              setState(() {
                                countdownSeconds--;
                              });
                              if (countdownSeconds == 0) {
                                timer.cancel(); // Stop the countdown timer
                                setState(() {
                                  isResendButtonDisabled = false;
                                });
                              }
                            });

                            // Send code request here
                            String newOtp =
                                await AuthenService.verifyEmailRegister(
                                    userEmail);
                            setState(() {
                              otp = newOtp;
                            });

                            // // Clear the VerificationCodeField
                            // otpInput = '';
                          },
                    child: Text(
                      isResendButtonDisabled
                          ? 'Resend Code (${countdownSeconds}s)'
                          : 'Resend Code',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: isResendButtonDisabled
                            ? ColorHelper.getColor('#7E7E7E')
                            : ColorHelper.getColor(ColorHelper.green),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      PageTransition(
                        child: VerifyEmailScreen(email: userEmail),
                        type: PageTransitionType.rightToLeft,
                        duration: const Duration(milliseconds: 300),
                      ),
                    );
                  },
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
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (otpInput == otp) {
                      Navigator.of(context).push(
                        PageTransition(
                          child: ProfileScreen(email: userEmail),
                          type: PageTransitionType.rightToLeft,
                          duration: const Duration(milliseconds: 300),
                        ),
                      );
                    } else {
                      // Show error message
                      QuickAlert.show(
                        context: context,
                        type: QuickAlertType.error,
                        title: 'Error',
                        text: 'Invalid code. Please try again.',
                        autoCloseDuration: const Duration(seconds: 3),
                      );
                    }
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
        ),
      ),
    );
  }
}
