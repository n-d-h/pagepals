import 'package:flutter/material.dart';

class UploadButton extends StatelessWidget {
  final Function() onTap;
  final Color iconColor;
  final String title;

  const UploadButton(
      {super.key,
      required this.onTap,
      required this.iconColor,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        InkWell(
          onTap: onTap,
          child: Container(
            height: 120,
            width: 120,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey[300]!,
                  blurRadius: 5,
                  spreadRadius: 2,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.cloud_upload,
                  size: 50,
                  color: iconColor,
                ),
                Text(title),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
