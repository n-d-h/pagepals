import 'package:flutter/material.dart';

class FunctionWidget extends StatelessWidget {
  FunctionWidget({
    super.key,
    this.onTap,
    this.icon,
    this.title,
  });

  Function()? onTap;
  Icon? icon;
  String? title;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.all(10),
        width: 120,
        height: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.deepOrangeAccent,
                borderRadius: BorderRadius.circular(6),
              ),
              child: icon,
            ),
            const SizedBox(height: 8),
            Text(
              title ?? '',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
