import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pagepals/models/booking_model.dart';
import 'package:pagepals/screens/screens_customer/order_screen/upcoming_tab_widgets/upcoming_body_widgets/column_detail_rows.dart';
import 'package:pagepals/screens/screens_customer/order_screen/upcoming_tab_widgets/upcoming_body_widgets/info_name.dart';

class BookingBody extends StatelessWidget {
  final Booking booking;
  final bool? isReader;

  const BookingBody({super.key, required this.booking, this.isReader});

  @override
  Widget build(BuildContext context) {
    String bookImage = booking.service != null
        ? booking.service?.book?.smallThumbnailUrl ??
            'https://via.placeholder.com/300'
        : booking.seminar?.book?.smallThumbnailUrl ??
            'https://via.placeholder.com/300';
    String readerNickname = booking.meeting!.reader!.nickname!;
    String readerUsername = '@${booking.meeting!.reader!.account!.username!}';

    String customerName = booking.customer!.fullName!;
    String customerUsername = '@${booking.customer!.account!.username!}';

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.black12, width: 1),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 125,
            width: 87,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              // color: Colors.green,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                bookImage,
                fit: BoxFit.fill,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InfoName(
                  nickname: isReader != null ? customerName : readerNickname,
                  username:
                      isReader != null ? customerUsername : readerUsername,
                ),
                ColumnDetail(
                  booking: booking,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
