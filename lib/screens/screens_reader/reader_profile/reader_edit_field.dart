import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ReaderEditField extends StatelessWidget {
  final String title;
  final String value;
  final Function() onTap;

  const ReaderEditField(
      {super.key,
      required this.title,
      required this.value,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        color: Colors.transparent,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        // margin: const EdgeInsets.only(bottom: 2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: Text(
                      textAlign: TextAlign.end,
                      value,
                      style: const TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontSize: 14,
                        color: Colors.grey,
                        fontWeight: FontWeight.w200,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 12,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
