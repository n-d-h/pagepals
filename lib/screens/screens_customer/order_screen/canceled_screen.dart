import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mobkit_dashed_border/mobkit_dashed_border.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pagepals/providers/notification_provider.dart';
import 'package:pagepals/screens/screens_customer/booking_screen/booking_widgets/bottom_nav_button.dart';
import 'package:pagepals/screens/screens_customer/booking_screen/booking_widgets/radio_buttons/radio_button.dart';
import 'package:pagepals/screens/screens_customer/menu_item/menu_item_screen.dart';
import 'package:pagepals/screens/screens_reader/reader_main_screen/reader_main_screen.dart';
import 'package:pagepals/services/authen_service.dart';
import 'package:pagepals/services/booking_service.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';

class CanceledScreen extends StatefulWidget {
  final Function(int)? onValueChanged;
  final String bookingId;
  final bool isReader;

  const CanceledScreen(
      {super.key,
      this.onValueChanged,
      required this.bookingId,
      required this.isReader});

  @override
  State<CanceledScreen> createState() => _CanceledScreenState();
}

class _CanceledScreenState extends State<CanceledScreen> {
  int? _selectedValue;
  String reason = '';

  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            'Cancel Booking',
            style: GoogleFonts.lexend(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          centerTitle: true,
          surfaceTintColor: Colors.white,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          )),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          controller: ScrollController(),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, bottom: 10),
                  child: Text(
                    'Please select the reason for cancellations:',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.black.withOpacity(0.5),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RadioButton(
                      text: 'Schedule Changed',
                      groupValue: _selectedValue,
                      value: 1,
                      onChanged: (value) {
                        setState(() {
                          _selectedValue = value;
                          reason = 'Schedule Changed';
                        });
                        widget.onValueChanged!(value!);
                      },
                    ),
                    RadioButton(
                      text: 'Unexpected event',
                      groupValue: _selectedValue,
                      value: 2,
                      onChanged: (value) {
                        setState(() {
                          _selectedValue = value;
                          reason = 'Unexpected event';
                        });
                        widget.onValueChanged!(value!);
                      },
                    ),
                    RadioButton(
                      text: 'I’ve change my mind',
                      groupValue: _selectedValue,
                      value: 3,
                      onChanged: (value) {
                        setState(() {
                          _selectedValue = value;
                          reason = 'I’ve change my mind';
                        });
                        widget.onValueChanged!(value!);
                      },
                    ),
                    RadioButton(
                      text: 'Device problems',
                      groupValue: _selectedValue,
                      value: 4,
                      onChanged: (value) {
                        setState(() {
                          _selectedValue = value;
                          reason = 'Device problems';
                        });
                        widget.onValueChanged!(value!);
                      },
                    ),
                    RadioButton(
                      text: 'Others',
                      groupValue: _selectedValue,
                      value: 5,
                      onChanged: (value) {
                        setState(() {
                          _selectedValue = value;
                        });
                        widget.onValueChanged!(value!);
                      },
                    ),
                  ],
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                  height: 1,
                  color: Colors.black.withOpacity(0.1),
                ),
                if (_selectedValue == 5)
                  Container(
                    margin:
                        const EdgeInsets.only(left: 20, right: 20, bottom: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Note:',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.black.withOpacity(0.5),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                            border: const DashedBorder.fromBorderSide(
                              dashLength: 15,
                              side: BorderSide(
                                color: Colors.grey,
                                width: 1,
                              ),
                            ),
                            // borderRadius: BorderRadius.all(Radius.circular(10))),
                          ),
                          child: TextField(
                            controller: controller,
                            maxLines: 7,
                            decoration: InputDecoration(
                              hintText: 'Type your note here ...',
                              hintStyle: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Colors.black.withOpacity(0.3),
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
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
          bool isCanceled = await BookingService.cancelBooking(
              widget.bookingId, _selectedValue == 5 ? controller.text : reason);

          if (isCanceled) {
            Future.delayed(Duration.zero, () async {
              // await AuthenService.updateAccountToSharedPreferences();
              var account = await AuthenService
                  .updateAndGetNewAccountFromSharePreference();
              Navigator.pop(context);
              context.read<NotificationProvider>().increment();
              Navigator.of(context).pushAndRemoveUntil(
                PageTransition(
                  child: widget.isReader
                      ? ReaderMainScreen(
                          accountModel: account,
                        )
                      : const MenuItemScreen(index: 3),
                  type: PageTransitionType.leftToRight,
                  duration: const Duration(milliseconds: 300),
                ),
                (route) => false,
              );

              QuickAlert.show(
                context: context,
                title: 'Booking Canceled',
                text: 'Your booking has been canceled successfully',
                type: QuickAlertType.success,
              );
            });
          }
        },
        isEnabled: _selectedValue == null
            ? false
            : _selectedValue == 5
                ? controller.text.isNotEmpty
                : true,
        title: 'Submit',
      ),
    );
  }
}
