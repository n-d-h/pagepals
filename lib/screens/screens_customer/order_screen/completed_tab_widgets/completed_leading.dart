import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:pagepals/models/booking_model.dart';

class CompletedLeading extends StatelessWidget {
  final Booking booking;

  const CompletedLeading({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    DateTime startTime = DateTime.parse(booking.startAt!);
    String date = DateFormat('MMM d, yyyy').format(startTime);
    String time = DateFormat('HH:mm').format(startTime);
    return Container(
      padding: const EdgeInsets.only(bottom: 14),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.black12, width: 1)),
      ),
      child: SizedBox(
        height: 20,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '$date - $time',
              style: GoogleFonts.lexend(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.black.withOpacity(0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
