import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pagepals/helpers/color_helper.dart';
import 'package:pagepals/screens/order_screen/canceled_tab_widgets/cancel_tab.dart';
import 'package:pagepals/screens/order_screen/completed_tab_widgets/completed_tab.dart';
import 'package:pagepals/screens/order_screen/upcoming_tab_widgets/upcoming_tab.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
            labelStyle: GoogleFonts.lexend(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
            unselectedLabelColor: Colors.grey.shade400,
            tabs: [
              Tab(text: AppLocalizations.of(context)!.appUpcoming),
              Tab(text: AppLocalizations.of(context)!.appCompleted),
              Tab(text: AppLocalizations.of(context)!.appCanceled),
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
