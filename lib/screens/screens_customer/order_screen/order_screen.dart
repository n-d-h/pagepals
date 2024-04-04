import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pagepals/helpers/color_helper.dart';
import 'package:pagepals/models/booking_model.dart';
import 'package:pagepals/screens/screens_customer/order_screen/canceled_tab_widgets/cancel_tab.dart';
import 'package:pagepals/screens/screens_customer/order_screen/completed_tab_widgets/completed_tab.dart';
import 'package:pagepals/screens/screens_customer/order_screen/upcoming_tab_widgets/upcoming_tab.dart';
import 'package:pagepals/services/booking_service.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  BookingModel? pendingBooking;
  BookingModel? completedBooking;
  BookingModel? canceledBooking;

  Future<void> getBooking() async {
    var pending = await BookingService.getBooking(0, 10, 'PENDING');
    var done = await BookingService.getBooking(0, 10, 'DONE');
    var cancel = await BookingService.getBooking(0, 10, 'CANCEL');
    setState(() {
      pendingBooking = pending;
      completedBooking = done;
      canceledBooking = cancel;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getBooking();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: pendingBooking == null ||
              completedBooking == null ||
              canceledBooking == null
          ? Scaffold(
              backgroundColor: Colors.white,
              body: Center(
                child: LoadingAnimationWidget.staggeredDotsWave(
                  color: Colors.green,
                  size: 60,
                ),
              ),
            )
          : Scaffold(
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
              body: TabBarView(
                children: [
                  UpcomingTab(bookingModel: pendingBooking),
                  CompletedTab(bookingModel: completedBooking),
                  CanceledTab(bookingModel: canceledBooking),
                ],
              ),
            ),
    );
  }
}
