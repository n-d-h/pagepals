import 'package:flutter/material.dart';
import 'package:pagepals/screens/signin_screen/signin_intro/box_buttons/signin_box_widget.dart';

class SignInBoxButtons extends StatelessWidget {
  const SignInBoxButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 140,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              SignInBoxWidget(text: 'Find a Service'),
              SizedBox(width: 20),
              SignInBoxWidget(text: 'Become a Reader'),
            ],
          ),
        ],
      ),
    );
  }
}
