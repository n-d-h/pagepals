import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pagepals/models/booking_model.dart';
import 'package:pagepals/screens/screens_customer/order_screen/upcoming_tab_widgets/upcoming_body_widgets/column_detail_rows.dart';
import 'package:pagepals/screens/screens_customer/order_screen/upcoming_tab_widgets/upcoming_body_widgets/reader_name.dart';

class BookingBody extends StatelessWidget {
  final Booking booking;

  const BookingBody({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    String bookImage = booking.service?.book?.smallThumbnailUrl ?? 'https://via.placeholder.com/150';
    String nickname = booking.meeting!.reader!.nickname!;
    String username = '@${booking.meeting!.reader!.account!.username!}';
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.black12, width: 1))),
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
                ReaderName(
                  nickname: nickname,
                  username: username,
                ),
                ColumnDetail(booking: booking,),
              ],
            ),
          )
        ],
      ),
    );
  }
}
