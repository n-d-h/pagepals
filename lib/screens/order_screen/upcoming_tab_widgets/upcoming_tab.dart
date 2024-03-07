import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pagepals/screens/order_screen/upcoming_tab_widgets/upcoming_body.dart';
import 'package:pagepals/screens/order_screen/upcoming_tab_widgets/upcoming_bottom.dart';
import 'package:pagepals/screens/order_screen/upcoming_tab_widgets/upcoming_leading.dart';
import 'package:pagepals/screens/order_screen/video_conference_page.dart';

class UpcomingTab extends StatelessWidget {
  const UpcomingTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 25, 20, 10),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                PageTransition(
                  child: const VideoConferencePage(conferenceID: '2147'),
                  type: PageTransitionType.fade,
                  duration: const Duration(milliseconds: 300),
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                border: Border.all(
                    width: 0.3, color: Colors.black.withOpacity(0.4)),
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
          ),
        ],
      ),
    );
  }
}
