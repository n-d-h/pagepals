import 'package:flutter/material.dart';
import 'package:pagepals/screens/order_screen/upcoming_tab_widgets/upcoming_body_widgets/column_detail_rows.dart';
import 'package:pagepals/screens/order_screen/upcoming_tab_widgets/upcoming_body_widgets/reader_name.dart';

class UpcomingBody extends StatelessWidget {
  const UpcomingBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.black12, width: 1))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox.square(
            dimension: 90,
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                // color: Colors.green,
              ),
              child: Image.asset('assets/thobaymau.png'),
            ),
          ),
          const SizedBox(width: 10),
          const Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ReaderName(
                nickname: 'Bùi Lễ Văn Minh',
                username: '@minmin',
              ),
              ColumnDetail(),
            ],
          )
        ],
      ),
    );
  }
}
