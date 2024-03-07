import 'package:flutter/material.dart';
import 'package:pagepals/helpers/space_helper.dart';

class ReaderInfoLine extends StatelessWidget {
  final IconData iconData;
  final String title;
  final String content;
  const ReaderInfoLine({super.key, required this.iconData, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              iconData,
              size: 35,
              color: Colors.grey.withOpacity(0.5),
            ),
            const SizedBox(width: SpaceHelper.space8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.grey.withOpacity(0.7),
                  ),
                ),
                Text(
                  content,
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
              ],
            )

          ],
        ),
        const SizedBox(height: SpaceHelper.space12),
      ],
    );
  }
}
