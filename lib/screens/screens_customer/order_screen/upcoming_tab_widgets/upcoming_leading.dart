import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:pagepals/models/booking_model.dart';

class UpcomingLeading extends StatefulWidget {
  final Booking booking;

  const UpcomingLeading({super.key, required this.booking});

  @override
  State<UpcomingLeading> createState() => _UpcomingLeadingState();
}

class _UpcomingLeadingState extends State<UpcomingLeading> {
  bool light = true;

  @override
  Widget build(BuildContext context) {
    DateTime startTime = DateTime.parse(widget.booking.startAt!);
    String date = DateFormat('MMM d, yyyy').format(startTime);
    String time = DateFormat('HH:mm').format(startTime);
    return Container(
      padding: const EdgeInsets.only(bottom: 14),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.black12, width: 1)),
      ),
      child: SizedBox(
        height: 40,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '$date - $time',
              style: GoogleFonts.lexend(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.black.withOpacity(0.7),
              ),
            ),
            const SizedBox(width: 10),
            widget.booking.service != null
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 35,
                        width: 70,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Center(
                          child: Text(
                            'Service',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 35,
                        width: 70,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Center(
                          child: Text(
                            'Seminar',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
