import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimeRowWidget extends StatelessWidget {
  final DateTime time;
  const TimeRowWidget({super.key, required this.time});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 15,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Date & Hour',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.grey,
              ),
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: DateFormat('MMMM d, yyyy').format(time),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                  const TextSpan(
                    text: ' | ',
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey, // Change color here
                    ),
                  ),
                  TextSpan(
                    text: DateFormat('HH:mm').format(time),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ],
    );
  }
}
