import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pagepals/helpers/color_helper.dart';
import 'package:pagepals/models/authen_models/account_model.dart';
import 'package:pagepals/models/book_models/book_model.dart';
import 'package:pagepals/screens/screens_customer/post_screen/event_widgets/event_detail.dart';
import 'package:pagepals/screens/screens_customer/post_screen/event_widgets/show_html_widget.dart';
import 'package:pagepals/services/authen_service.dart';
import 'package:pagepals/services/event_service.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EventPostItem extends StatefulWidget {
  final String eventId;
  final String hostName;
  final String seminarTitle;
  final String date;
  final String time;
  final String description;
  final String hostAvatarUrl;
  final String bannerImageUrl;
  final int price;
  final int limitCustomer;
  final int activeSlot;
  final Book book;
  final Function(bool) onEventBookedDone;

  const EventPostItem({
    Key? key,
    required this.eventId,
    required this.hostName,
    required this.seminarTitle,
    required this.time,
    required this.description,
    required this.hostAvatarUrl,
    required this.bannerImageUrl,
    required this.date,
    required this.price,
    required this.limitCustomer,
    required this.activeSlot,
    required this.book,
    required this.onEventBookedDone,
  }) : super(key: key);

  @override
  _EventPostItemState createState() => _EventPostItemState();
}

class _EventPostItemState extends State<EventPostItem> {
  int interestedCount = 0;
  bool interested = false;

  Future<void> joinSeminar() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? account = prefs.getString('account');
      AccountModel? accountModel = AccountModel.fromJson(jsonDecode(account!));
      String customerId = accountModel.customer?.id ?? '';

      bool results = await EventService.bookEvent(customerId, widget.eventId);
      if (results) {
        widget.onEventBookedDone(true);

        SharedPreferences prefs = await SharedPreferences.getInstance();
        String? accountString = prefs.getString('account');
        String accessToken = prefs.getString('accessToken')!;
        if (accountString == null) {
          print('No account data found in SharedPreferences');
          return;
        }
        try {
          AccountModel account =
              AccountModel.fromJson(json.decoder.convert(accountString));
          String userName = account.username!;

          AccountModel updatedAccount =
              await AuthenService.getAccount(userName, accessToken);
          prefs.remove('account');
          print('account: ${json.encode(updatedAccount)}');
          prefs.setString('account', json.encode(updatedAccount));
        } catch (e) {
          print('Error decoding account data: $e');
        }

        Future.delayed(Duration(milliseconds: 100), () {
          QuickAlert.show(
            context: context,
            type: QuickAlertType.success,
            title: 'Success',
            text: 'Join event successfully',
          );
        });
      } else {
        Future.delayed(Duration(milliseconds: 100), () {
          QuickAlert.show(
            context: context,
            type: QuickAlertType.error,
            title: 'Failed',
            text: 'Join event failed',
          );
        });
      }
    } catch (e) {
      if (e.toString().contains('Not enough money')) {
        Future.delayed(Duration(milliseconds: 100), () {
          QuickAlert.show(
            context: context,
            type: QuickAlertType.error,
            title: 'Failed',
            text: 'Not enough money',
          );
        });
      }

      if (e.toString().contains('Cannot book your own event')) {
        Future.delayed(Duration(milliseconds: 100), () {
          QuickAlert.show(
            context: context,
            type: QuickAlertType.error,
            title: 'Failed',
            text: 'Cannot book your own event',
          );
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
      margin: const EdgeInsets.only(bottom: 10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 24,
                backgroundImage: NetworkImage(widget.hostAvatarUrl),
              ),
              const SizedBox(width: 12.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.seminarTitle,
                      style: GoogleFonts.lexend(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 2.0),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Hosted by: ',
                            style: GoogleFonts.lexend(
                              fontSize: 14.0,
                              color: Colors.grey,
                            ),
                          ),
                          TextSpan(
                            text: widget.hostName,
                            style: GoogleFonts.lexend(
                              fontSize: 14.0,
                              color: ColorHelper.getColor(
                                ColorHelper.green,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 2.0),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Date: ',
                            style: GoogleFonts.lexend(
                              fontSize: 14.0,
                              color: Colors.grey,
                            ),
                          ),
                          TextSpan(
                            text: '${widget.date}',
                            style: GoogleFonts.lexend(
                              fontSize: 14.0,
                              color: ColorHelper.getColor(
                                ColorHelper.green,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 2.0),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Time: ',
                            style: GoogleFonts.lexend(
                              fontSize: 14.0,
                              color: Colors.grey,
                            ),
                          ),
                          TextSpan(
                            text: '${widget.time}',
                            style: GoogleFonts.lexend(
                              fontSize: 14.0,
                              color: ColorHelper.getColor(
                                ColorHelper.green,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                PageTransition(
                  child: EventPostDetailScreen(
                    eventId: widget.eventId,
                    hostName: widget.hostName,
                    seminarTitle: widget.seminarTitle,
                    date: widget.date,
                    time: widget.time,
                    description: widget.description,
                    hostAvatarUrl: widget.hostAvatarUrl,
                    bannerImageUrl: widget.bannerImageUrl,
                    activeSlot: widget.activeSlot,
                    limitCustomer: widget.limitCustomer,
                    price: widget.price,
                    book: widget.book,
                    onEventBookedDone: (bool isBooked) {
                      widget.onEventBookedDone(isBooked);
                    },
                  ),
                  type: PageTransitionType.fade,
                  duration: const Duration(milliseconds: 300),
                ),
              );
            },
            child: ShowMoreHtmlWidget(
              htmlContent: widget.description,
              maxLines: 2,
              isShowShortText: true,
            ),
          ),
          const SizedBox(height: 8.0),
          Image.network(
            widget.bannerImageUrl,
            height: 200.0,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: () {
                  handleJoinSeminar();
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12.0,
                    vertical: 8.0,
                  ),
                  margin: const EdgeInsets.only(bottom: 8.0),
                  decoration: BoxDecoration(
                    color: ColorHelper.getColor(ColorHelper.green),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.add, color: Colors.white),
                      SizedBox(width: 4.0),
                      Text(
                        'Join Seminar',
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void handleJoinSeminar() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Join Seminar',
            textAlign: TextAlign.center,
          ),
          surfaceTintColor: Colors.white,
          backgroundColor: Colors.white,
          content: Container(
            height: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Are you sure you want to join this seminar?',
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                const SizedBox(height: 8.0),
                Row(
                  children: [
                    Text(
                      'Price: ',
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                    Text(
                      '${widget.price} pals',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8.0),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Available: ',
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                    Text(
                      '${widget.activeSlot} slots',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2.0),
                Text(
                  'Note: You can not cancel this seminar booking once confirmed.',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.normal,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('No'),
            ),
            TextButton(
              onPressed: () async {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: Text('Joining event...'),
                    content: Container(
                      height: 100,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(),
                          const SizedBox(height: 8.0),
                          Text('Please wait...'),
                        ],
                      ),
                    ),
                  ),
                );
                await joinSeminar();
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: Text('Yes'),
            ),
          ],
        );
      },
    );
  }
}
