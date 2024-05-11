import 'package:flutter/material.dart';

class SpaceBetweenRowWidget extends StatelessWidget {
  final String start;
  final String end;
  final double width;

  const SpaceBetweenRowWidget({
    super.key,
    required this.start,
    required this.end,
    this.width = 113,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: width,
              child: Text(
                start,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.black87.withOpacity(0.5),
                ),
              ),
            ),
            Expanded(
              child: Text(
                textAlign: TextAlign.end,
                end,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
