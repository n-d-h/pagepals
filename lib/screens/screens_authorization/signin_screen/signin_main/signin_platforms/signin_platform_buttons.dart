import 'package:flutter/material.dart';
import 'package:pagepals/helpers/space_helper.dart';
import 'package:pagepals/screens/screens_authorization/signin_screen/signin_main/signin_platforms/facebook_button.dart';
import 'package:pagepals/screens/screens_authorization/signin_screen/signin_main/signin_platforms/google_button.dart';

class PlatformButtons extends StatelessWidget {
  const PlatformButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        FaceBookSignIn(),
        SizedBox(
          width: SpaceHelper.space16,
        ),
        GoogleSignIn(),
      ],
    );
  }
}
