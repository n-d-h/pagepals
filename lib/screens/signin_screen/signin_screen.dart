import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pagepals/helpers/color_helper.dart';
import 'package:pagepals/helpers/space_helper.dart';
import 'package:pagepals/screens/dash_board/dash_board_screen.dart';
import 'package:pagepals/screens/signin_screen/signin_home.dart';
import 'package:pagepals/screens/signup_screen/signup_screen.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  bool _obscurePassword = true; // State variable to toggle password visibility
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            margin: const EdgeInsets.fromLTRB(20, 100, 20, 0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Image(
                    image: AssetImage('assets/signin_logo.png'),
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: SpaceHelper.space8),
                  Text(
                    "Welcome back",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: ColorHelper.getColor(ColorHelper.black),
                    ),
                  ),
                  const SizedBox(height: SpaceHelper.space8),
                  Text(
                    'Sign in to PagePals to pick up exactly where you left off.',
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
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              foregroundColor:
                                  ColorHelper.getColor(ColorHelper.black),
                              backgroundColor:
                                  ColorHelper.getColor(ColorHelper.gray),
                              padding: const EdgeInsets.symmetric(
                                horizontal: SpaceHelper.space8,
                                vertical: 1.5,
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
                                      image: AssetImage('assets/facebook.png'),
                                      fit: BoxFit.scaleDown,
                                    )),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    'Facebook',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                )
                              ],
                            )),
                      ),
                      const SizedBox(
                        width: SpaceHelper.space16,
                      ),
                      Expanded(
                        flex: 1,
                        child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              foregroundColor:
                                  ColorHelper.getColor(ColorHelper.black),
                              backgroundColor:
                                  ColorHelper.getColor(ColorHelper.gray),
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
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Center(
                      child: RichText(
                    text: TextSpan(
                        text: 'or sign in with ',
                        style: TextStyle(
                          fontSize: SpaceHelper.fontSize16,
                          fontWeight: FontWeight.w600,
                          color: ColorHelper.getColor(ColorHelper.black),
                        ),
                        children: [
                          TextSpan(
                            text: ' PagePals  ',
                            style: TextStyle(
                              fontSize: SpaceHelper.fontSize16,
                              fontWeight: FontWeight.w600,
                              color: ColorHelper.getColor(ColorHelper.green),
                            ),
                          ),
                          TextSpan(
                            text: 'account',
                            style: TextStyle(
                              fontSize: SpaceHelper.fontSize16,
                              fontWeight: FontWeight.w600,
                              color: ColorHelper.getColor(ColorHelper.black),
                            ),
                          )
                        ]),
                  )),
                  const SizedBox(
                    height: 30,
                  ),
                  // Email Input
                  TextField(
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
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 10),

                  // Password Input
                  TextField(
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
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                    ),
                    obscureText: _obscurePassword,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: double.infinity, // <-- match_parent
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          PageTransition(
                            child: const DashBoardScreen(),
                            type: PageTransitionType.bottomToTop,
                            duration: const Duration(milliseconds: 300),
                          ),
                        );
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
                    height: 23,
                  ),
                  Center(
                      child: TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        PageTransition(
                          child: const SigninHomeScreen(),
                          type: PageTransitionType.bottomToTop,
                          duration: const Duration(milliseconds: 300),
                        ),
                      );
                    },
                    child: Text(
                      'Forgot password?',
                      style: TextStyle(
                          fontSize: SpaceHelper.fontSize16,
                          fontWeight: FontWeight.w600,
                          color: ColorHelper.getColor(ColorHelper.green)),
                    ),
                  ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
