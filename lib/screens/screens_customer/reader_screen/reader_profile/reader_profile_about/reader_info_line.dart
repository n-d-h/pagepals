import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pagepals/helpers/space_helper.dart';

class ReaderInfoLine extends StatelessWidget {
  final IconData iconData;
  final String title;
  final String content;

  const ReaderInfoLine(
      {super.key,
      required this.iconData,
      required this.title,
      required this.content});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                iconData,
                size: 35,
                color: Colors.grey.withOpacity(0.5),
              ),
              const SizedBox(width: SpaceHelper.space8),
              Expanded(
                child: Column(
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
                      overflow: TextOverflow.clip,
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: SpaceHelper.space12),
        ],
      ),
    );
  }
}
