import 'package:flutter/material.dart';
import 'package:pagepals/models/booking_model.dart';
import 'package:pagepals/screens/screens_customer/order_screen/upcoming_tab_widgets/upcoming_body_widgets/detail_row.dart';
import 'package:unicons/unicons.dart';

class ColumnDetail extends StatelessWidget {
  final Booking booking;

  const ColumnDetail({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    String title = booking.service != null
        ? booking.service?.book?.title ?? 'Unknown'
        : booking.seminar?.book?.title ?? 'Unknown';
    String service = booking.service?.description ?? 'Unknown';
    String seminar = booking.seminar?.description ?? 'Unknown';
    String meetingCode = "#${booking.meeting!.meetingCode!}";
    String duration =
        '${booking.seminar?.duration != null ? booking.seminar!.duration!.toInt() : booking.service?.duration != null ? booking.service!.duration!.toInt() : '60'} minutes';
    Color? color = booking.service == null ? Colors.blueAccent : null;
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DetailRow(
            icon: UniconsLine.book_alt,
            text: 'Book: $title',
            color: color,
          ),
          SizedBox(height: 2),
          booking.service != null
              ? DetailRow(
                  icon: UniconsLine.pen,
                  text: 'Service: $service',
                  color: color,
                )
              : DetailRow(
                  icon: UniconsLine.pen,
                  text: 'Seminar: $seminar',
                  color: color,
                ),
          SizedBox(height: 2),
          DetailRow(
            icon: UniconsLine.rocket,
            text: 'Meeting Code: $meetingCode',
            color: color,
          ),
          SizedBox(height: 2),
          DetailRow(
            icon: UniconsLine.clock,
            text: 'Duration: $duration',
            color: color,
          ),
        ],
      ),
    );
  }
}
