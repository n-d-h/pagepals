import 'package:flutter/material.dart';
import 'package:pagepals/helpers/color_helper.dart';
import 'package:pagepals/helpers/space_helper.dart';

class FaceBookSignIn extends StatelessWidget {
  const FaceBookSignIn({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            foregroundColor: ColorHelper.getColor(ColorHelper.black),
            backgroundColor: ColorHelper.getColor(ColorHelper.gray),
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
    );
  }
}
