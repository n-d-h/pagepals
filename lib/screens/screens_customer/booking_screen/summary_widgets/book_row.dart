import 'package:flutter/material.dart';

class BookRowWidget extends StatelessWidget {
  final String book;

  const BookRowWidget({super.key, required this.book});

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
              width: 113,
              // decoration: BoxDecoration(
              //   color: Colors.grey.withOpacity(1),
              // ),
              margin: const EdgeInsets.only(right: 10),
              child: Text(
                'Book',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: Colors.black87.withOpacity(0.5),
                ),
              ),
            ),
            Expanded(
              child: Text(
                book,
                textAlign: TextAlign.end,
                style: const TextStyle(
                  fontSize: 18,
                  overflow: TextOverflow.clip,
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
