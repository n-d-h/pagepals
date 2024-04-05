import 'package:flutter/material.dart';
import 'package:pagepals/helpers/color_helper.dart';
import 'package:pagepals/helpers/space_helper.dart';

class BottomButton extends StatelessWidget {
  final Function()? onPressed;
  final bool isEnabled;
  final String title;

  const BottomButton(
      {Key? key,
      required this.onPressed,
      required this.isEnabled,
      required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20),
        ),
        color: Colors.white,
        // Adjust background color
        boxShadow: [
          BoxShadow(color: Colors.black12, spreadRadius: 2, blurRadius: 3),
        ],
      ),
      child: Center(
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 30),
          child: OutlinedButton(
            onPressed: isEnabled ? onPressed : null,
            // Disable button if not enabled
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Colors.transparent),
              foregroundColor: isEnabled
                  ? ColorHelper.getColor(ColorHelper.white)
                  : Colors.grey,
              backgroundColor: isEnabled
                  ? ColorHelper.getColor(ColorHelper.green)
                  : Colors.grey.withOpacity(0.3),
              padding: const EdgeInsets.symmetric(
                horizontal: SpaceHelper.space16,
                vertical: 12,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
            ),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
