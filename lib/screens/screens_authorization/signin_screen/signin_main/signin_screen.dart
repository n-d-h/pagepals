import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pagepals/helpers/color_helper.dart';
import 'package:pagepals/helpers/space_helper.dart';
import 'package:pagepals/models/authen_models/account_tokens.dart';
import 'package:pagepals/models/authen_models/login_model.dart';
import 'package:pagepals/screens/screens_authorization/signin_screen/signin_main/signin_account/signin_account_leading.dart';
import 'package:pagepals/screens/screens_authorization/signin_screen/signin_main/signin_buttons/forgot_password_button.dart';
import 'package:pagepals/screens/screens_authorization/signin_screen/signin_main/signin_leading.dart';
import 'package:pagepals/screens/screens_authorization/signin_screen/signin_main/signin_platforms/signin_platform_buttons.dart';
import 'package:pagepals/screens/screens_customer/menu_item/menu_item_screen.dart';
import 'package:pagepals/services/authen_service.dart';
import 'package:pagepals/services/firebase_message_service.dart';
import 'package:quickalert/quickalert.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  bool _obscurePassword = true; // State variable to toggle password visibility
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _emailValidated = true;
  bool _passwordValidated = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        surfaceTintColor: Colors.transparent,
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
      body: GestureDetector(
        onTap: () {
          // Handle tap on screen to dismiss keyboard
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          controller: ScrollController(),
          child: Container(
            width:
                MediaQuery.of(context).size.width * SpaceHelper.spaceNineTenths,
            margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SignInLeadingTexts(),
                  const PlatformButtons(),
                  const SizedBox(height: 30),
                  const SignInAccLeadingText(),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    controller: _emailController,
                    decoration: InputDecoration(
                      hintText: 'Email or username',
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 12),
                      hintStyle:
                          const TextStyle(fontSize: 16, color: Colors.grey),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: ColorHelper.getColor(ColorHelper.grey),
                            width: 1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: ColorHelper.getColor(ColorHelper.green),
                            width: 2),
                        // Customize the focused border color if needed
                        borderRadius: BorderRadius.circular(12),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Colors.red, // Color for error border
                            width: 2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Colors.red,
                            // Color for focused error border
                            width: 2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      errorText: _emailValidated
                          ? null
                          : 'Please enter your email or username',
                      // Display error message if validation fails
                    ),
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) {
                      setState(() {
                        _emailValidated = true;
                      });
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    controller: _passwordController,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 12),
                      hintStyle:
                          const TextStyle(fontSize: 16, color: Colors.grey),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: ColorHelper.getColor(ColorHelper.grey),
                            width: 1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: ColorHelper.getColor(ColorHelper.green),
                            width: 2),
                        // Customize the focused border color if needed
                        borderRadius: BorderRadius.circular(12),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Colors.red, // Color for error border
                            width: 2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Colors.red,
                            // Color for focused error border
                            width: 2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      errorText: _passwordValidated
                          ? null
                          : 'Please enter your password',
                      // Display error message if validation fails
                    ),
                    obscureText: _obscurePassword,
                    onChanged: (value) {
                      setState(() {
                        _passwordValidated = true;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        setState(() {
                          _emailValidated = _emailController.text.isNotEmpty;
                          _passwordValidated =
                              _passwordController.text.isNotEmpty;
                        });

                        if (_emailValidated && _passwordValidated) {
                          LoginModel loginModel = LoginModel(
                            username: _emailController.text,
                            password: _passwordController.text,
                          );

                          // Show the loading dialog
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return Center(
                                child: LoadingAnimationWidget.staggeredDotsWave(
                                  color: Colors.greenAccent,
                                  size: 60,
                                ),
                              );
                            },
                          );

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

                          try {
                            AccountTokens? accountTokens =
                                await AuthenService.login(loginModel);
                            // Handle successful login here
                            if (accountTokens != null) {
                              String accountId = accountTokens.accountId ?? '';
                              await AuthenService.updateFcmToken(
                                  fcmToken, accountId, false);

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
                            Future.delayed(const Duration(milliseconds: 100),
                                () {
                              Navigator.pop(context);
                              QuickAlert.show(
                                context: context,
                                type: QuickAlertType.error,
                                title: 'Login Failed',
                                text: 'Incorrect username or password',
                              );
                            });
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor:
                            ColorHelper.getColor(ColorHelper.white),
                        backgroundColor:
                            ColorHelper.getColor(ColorHelper.green),
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
                  const SizedBox(
                    height: 20,
                  ),
                  const ForgotPasswordButton()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
