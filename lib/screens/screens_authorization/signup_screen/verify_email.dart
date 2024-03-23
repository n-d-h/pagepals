import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pagepals/helpers/color_helper.dart';
import 'package:pagepals/helpers/space_helper.dart';
import 'package:pagepals/screens/screens_authorization/signup_screen/verify_code.dart';
import 'package:pagepals/services/authen_service.dart';

class VerifyEmailScreen extends StatefulWidget {
  final String? email;

  const VerifyEmailScreen({Key? key, this.email}) : super(key: key);

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  final TextEditingController _emailController = TextEditingController();
  Color _buttonColor = ColorHelper.getColor(ColorHelper.grey); // Initialize button color to grey

  @override
  void initState() {
    super.initState();
    if (widget.email != null) {
      _emailController.text = widget.email!;
      _updateButtonColor(); // Update button color initially
    }
  }

  void _updateButtonColor() {
    setState(() {
      _buttonColor = _emailController.text.isEmpty
          ? ColorHelper.getColor(ColorHelper.grey)
          : ColorHelper.getColor(ColorHelper.green);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorHelper.getColor(ColorHelper.lightActive),
          title: const Text(
            'Create account',
            style: TextStyle(
              color: Colors.black,
              fontSize: SpaceHelper.space24,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: Container(
          width: MediaQuery.of(context).size.width * SpaceHelper.spaceNineTenths,
          margin: const EdgeInsets.fromLTRB(20, 0, 20, 50),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  controller: _emailController,
                  onChanged: (_) => _updateButtonColor(), // Update button color when text changes
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.alternate_email_outlined),
                    prefixIconColor: Colors.grey,
                    hintText: 'Input your email here',
                    hintStyle: const TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                        fontWeight: FontWeight.w600),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 12),
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
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _emailController.text.isEmpty
                        ? null
                        : () async {
                      String otp = await AuthenService.verifyEmailRegister(
                          _emailController.text);
                      Future.delayed(Duration.zero, () {
                        Navigator.of(context).push(
                          PageTransition(
                            child: VerifyCodeScreen(
                              email: _emailController.text,
                              otp: otp,
                            ),
                            type: PageTransitionType.rightToLeft,
                            duration: const Duration(milliseconds: 300),
                          ),
                        );
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: ColorHelper.getColor(ColorHelper.white),
                      backgroundColor: _buttonColor, // Use dynamic button color
                      padding: const EdgeInsets.symmetric(
                        horizontal: SpaceHelper.space16,
                        vertical: 9,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Verify Email',
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
      ),
    );
  }
}
