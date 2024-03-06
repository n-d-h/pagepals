import 'package:flutter/material.dart';
import 'package:pagepals/screens/order_screen/upcoming_tab_widgets/upcoming_body.dart';
import 'package:pagepals/screens/order_screen/upcoming_tab_widgets/upcoming_bottom.dart';
import 'package:pagepals/screens/order_screen/upcoming_tab_widgets/upcoming_leading.dart';

class UpcomingTab extends StatelessWidget {
  const UpcomingTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 25, 20, 10),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              border:
                  Border.all(width: 0.3, color: Colors.black.withOpacity(0.4)),
              // boxShadow: [
              //   BoxShadow(color: Colors.black12, spreadRadius: 2, blurRadius: 3),
              // ],
              boxShadow: [
                BoxShadow(
                  color: Colors.black12.withOpacity(0.2),
                  // spreadRadius: 2,
                  blurRadius: 3,
                  offset: const Offset(0, 5),
                )
              ],
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                UpcomingLeading(),
                UpcomingBody(),
                UpcomingBottom(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
