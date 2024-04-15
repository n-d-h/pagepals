import 'package:flutter/material.dart';

class UploadButton extends StatelessWidget {
  final Function() onTap;
  final Icon icon;
  final String title;
  final Function()? onCanceled;

  const UploadButton(
      {super.key,
      required this.onTap,
      required this.icon,
      required this.title, this.onCanceled});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
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
                icon,
                Text(title),
              ],
            ),
          ),
        ),
        onCanceled != null
            ? InkWell(
                onTap: onCanceled,
                child: Container(
                  margin: const EdgeInsets.only(top: 10),
                  height: 40,
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
                  child: const Center(
                    child: Text(
                      'Cancel',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ),
              )
            : const SizedBox(),
      ],
    );
  }
}
