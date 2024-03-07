import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pagepals/helpers/color_helper.dart';
import 'package:pagepals/helpers/space_helper.dart';
import 'package:pagepals/screens/order_screen/canceled_tab_widgets/cancel_tab.dart';
import 'package:pagepals/screens/order_screen/completed_tab_widgets/completed_tab.dart';
import 'package:pagepals/screens/order_screen/upcoming_tab_widgets/upcoming_tab.dart';
import 'package:pagepals/screens/search_screen/book_tab_screen.dart';
import 'package:pagepals/screens/search_screen/reader_tab_screen.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              'My Booking',
              style: GoogleFonts.lexend(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),
          bottom: TabBar(
            indicatorColor: ColorHelper.getColor(ColorHelper.green),
            indicatorSize: TabBarIndicatorSize.tab,
            labelColor: ColorHelper.getColor(ColorHelper.green),
            labelStyle: GoogleFonts.lexend(),
            tabs: const [
              Tab(text: 'Upcoming'),
              Tab(text: 'Completed'),
              Tab(text: 'Cancelled')
            ],
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.search_rounded,
                color: Colors.black,
              ),
            ),
          ],
        ),
        body: const TabBarView(
          children: [
            UpcomingTab(),
            CompletedTab(),
            CanceledTab(),
          ],
        ),
      ),
    );
  }
}
