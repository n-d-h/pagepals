import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:pagepals/helpers/color_helper.dart';
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
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'Remind me  ',
                  style: GoogleFonts.lexend(
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                    color: Colors.black.withOpacity(0.6),
                  ),
                ),
                // FlutterSwitch(
                //   value: light,
                //   activeColor: ColorHelper.getColor(ColorHelper.green),
                //   onChanged: (bool value) {
                //     setState(() {
                //       light = value;
                //     });
                //   },
                // ),
                FlutterSwitch(
                  width: 40.0,
                  height: 20.0,
                  activeColor: ColorHelper.getColor(ColorHelper.green),
                  inactiveColor: Colors.grey,
                  // valueFontSize: 25.0,
                  toggleSize: 18.0,
                  value: light,
                  borderRadius: 30.0,
                  padding: 1.0,
                  showOnOff: false,
                  onToggle: (bool val) {
                    setState(() {
                      light = val;
                    });
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
