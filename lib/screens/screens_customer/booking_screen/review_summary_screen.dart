import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pagepals/helpers/utils.dart';
import 'package:pagepals/models/authen_models/account_model.dart';
import 'package:pagepals/models/book_models/book_model.dart';
import 'package:pagepals/models/reader_models/reader_profile_model.dart';
import 'package:pagepals/providers/notification_provider.dart';
import 'package:pagepals/screens/screens_customer/booking_screen/booking_success_screen.dart';
import 'package:pagepals/screens/screens_customer/booking_screen/booking_widgets/bottom_nav_button.dart';
import 'package:pagepals/screens/screens_customer/booking_screen/summary_widgets/book_row.dart';
import 'package:pagepals/screens/screens_customer/booking_screen/summary_widgets/service_row.dart';
import 'package:pagepals/screens/screens_customer/booking_screen/summary_widgets/time_row.dart';
import 'package:pagepals/screens/screens_customer/booking_screen/summary_widgets/wallet_widget.dart';
import 'package:pagepals/services/authen_service.dart';
import 'package:pagepals/services/booking_service.dart';
import 'package:pagepals/widgets/reader_info_widget/reader_info.dart';
import 'package:pagepals/widgets/space_between_row_widget.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReviewSummaryScreen extends StatefulWidget {
  final ReaderProfile? reader;
  final DateTime time;
  final String timeSlotId;
  final Book? book;
  final Services? service;

  // final String? chapter;
  final ServiceType? serviceType;

  const ReviewSummaryScreen({
    super.key,
    this.reader,
    required this.time,
    required this.book,
    // required this.chapter,
    required this.serviceType,
    this.service,
    required this.timeSlotId,
  });

  @override
  State<ReviewSummaryScreen> createState() => _ReviewSummaryScreenState();
}

class _ReviewSummaryScreenState extends State<ReviewSummaryScreen> {
  AccountModel? accountModel;

  @override
  void initState() {
    super.initState();
    getAccount();
  }

  Future<void> getAccount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accountString = prefs.getString('account');
    if (accountString == null) {
      print('No account data found in SharedPreferences');
      return;
    }
    try {
      Map<String, dynamic> accountMap = json.decode(accountString);
      AccountModel account = AccountModel.fromJson(accountMap);
      setState(() {
        accountModel = account;
      });
    } catch (e) {
      print('Error decoding account data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    int amount = (widget.service?.price ?? 0);
    int promotion = 0;
    double total = amount - (amount * promotion / 100);

    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        title: const Text('Booking Detail'),
        centerTitle: true,
        titleTextStyle: const TextStyle(
          fontWeight: FontWeight.w700,
          color: Colors.black,
          fontSize: 24,
        ),
      ),
      body: SingleChildScrollView(
        controller: ScrollController(),
        physics: const BouncingScrollPhysics(),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ReaderInfoWidget(
                reader: widget.reader,
              ),
              TimeRowWidget(time: widget.time),
              SpaceBetweenRowWidget(
                start: 'Duration',
                end: '${widget.service!.duration!.toInt()} minutes',
              ),
              BookRowWidget(book: widget.book!.title!),
              ServiceRowWidget(
                service: widget.service!.description!,
                serviceType: widget.serviceType!.name!,
              ),
              const SizedBox(height: 16),
              Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 40),
                height: 1,
                color: Colors.black.withOpacity(0.1),
              ),
              SpaceBetweenRowWidget(
                start: 'Amount',
                end: '$amount pals',
              ),
              SpaceBetweenRowWidget(
                start: 'Promotion',
                end: '$promotion %',
              ),
              SpaceBetweenRowWidget(
                start: 'Total',
                end: '$total pals',
              ),
              WalletWidget(
                  accountModel: accountModel,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomButton(
        onPressed: () async {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return Center(
                child: LoadingAnimationWidget.staggeredDotsWave(
                  color: Colors.greenAccent,
                  size: 60,
                ),
              );
            },
          );

          if((accountModel?.wallet?.tokenAmount ?? 0) < total){
            Future.delayed(const Duration(milliseconds: 300), () {
              Navigator.of(context).pop();
              QuickAlert.show(
                context: context,
                type: QuickAlertType.error,
                title: 'Error',
                text: 'You do not have enough balance to book this service.',
                autoCloseDuration: const Duration(seconds: 3),
              );
            });
            return;
          }

          bool bookingCreated =
              await BookingService.createBooking("", widget.service!, widget.timeSlotId, "");
          if (!bookingCreated) {
            Future.delayed(const Duration(milliseconds: 300), () {
              Navigator.of(context).pop();
              QuickAlert.show(
                context: context,
                type: QuickAlertType.error,
                title: 'Error',
                text: 'An error occurred while booking. Please try again.',
                autoCloseDuration: const Duration(seconds: 3),
              );
            });
            return;
          } else {
            context.read<NotificationProvider>().increment();
            // Handle button press action here
            Future.delayed(const Duration(milliseconds: 100), () {
              Navigator.of(context).pop();
              Navigator.of(context).push(
                PageTransition(
                  child: BookingSuccessScreen(reader: widget.reader),
                  type: PageTransitionType.rightToLeft,
                  duration: const Duration(milliseconds: 300),
                ),
              );
            });
            Future.delayed(const Duration(milliseconds: 300), () {
              QuickAlert.show(
                context: context,
                type: QuickAlertType.success,
                title: 'Success Booking',
                text: 'Thank you for booking!',
                autoCloseDuration: const Duration(seconds: 3),
              );

              AuthenService.updateAccountToSharedPreferences();
            });
          }
        },
        title: 'Pay Now',
        isEnabled: true,
      ),
    );
  }
}
