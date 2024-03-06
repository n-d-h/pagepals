import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pagepals/screens/order_screen/upcoming_tab_widgets/upcoming_body_widgets/detail_row.dart';
import 'package:unicons/unicons.dart';

class ColumnDetail extends StatelessWidget {
  const ColumnDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 7),
      child: const Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DetailRow(
            icon: UniconsLine.book_alt,
            text: 'Book: Tết ở làng Địa Ngục',
          ),
          SizedBox(height: 2),
          DetailRow(
            icon: UniconsLine.pen,
            text: 'Chater 1: khởi nghĩa',
          ),
          SizedBox(height: 2),
          DetailRow(
            icon: UniconsLine.rocket,
            text: 'Service: Read book',
          ),
        ],
      ),
    );
  }
}
