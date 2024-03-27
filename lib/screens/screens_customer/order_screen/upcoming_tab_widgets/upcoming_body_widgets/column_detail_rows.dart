import 'package:flutter/material.dart';
import 'package:pagepals/models/booking_model.dart';
import 'package:pagepals/screens/screens_customer/order_screen/upcoming_tab_widgets/upcoming_body_widgets/detail_row.dart';
import 'package:unicons/unicons.dart';

class ColumnDetail extends StatelessWidget {
  final Booking booking;

  const ColumnDetail({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    String title = booking.service?.book?.title ?? 'Unknown';
    String service = booking.service?.description ?? 'Unknown';
    String meetingCode = "#${booking.meeting!.meetingCode!}";
    String duration =
        '${booking.service?.duration != null ? booking.service!.duration!.toInt() : '60'} minutes';
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
          ),
          SizedBox(height: 2),
          DetailRow(
            icon: UniconsLine.pen,
            text: 'Service: $service',
          ),
          SizedBox(height: 2),
          DetailRow(
            icon: UniconsLine.rocket,
            text: 'Meeting Code: $meetingCode',
          ),
          SizedBox(height: 2),
          DetailRow(
            icon: UniconsLine.clock,
            text: 'Duration: $duration',
          ),
        ],
      ),
    );
  }
}
