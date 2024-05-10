import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pagepals/helpers/color_helper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pagepals/models/authen_models/account_model.dart';
import 'package:pagepals/screens/screens_customer/post_screen/seminar_widgets/seminar_post_detail.dart';
import 'package:pagepals/services/authen_service.dart';
import 'package:pagepals/services/seminar_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EventPostItem extends StatefulWidget {
  final String seminarId;
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
  final Function(bool) onSeminarJoinedDone;

  const EventPostItem({
    Key? key,
    required this.seminarId,
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
    required this.onSeminarJoinedDone,
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

      bool results = await SeminarService.joinSeminar(customerId, widget.seminarId);
      if (results) {
        widget.onSeminarJoinedDone(true);

        SharedPreferences prefs = await SharedPreferences.getInstance();
        String? accountString = prefs.getString('account');
        String accessToken = prefs.getString('accessToken')!;
        if (accountString == null) {
          print('No account data found in SharedPreferences');
          return;
        }
        try {
          AccountModel account = AccountModel.fromJson(json.decoder.convert(accountString));
          String userName = account.username!;

          AccountModel updatedAccount = await AuthenService.getAccount(userName, accessToken);
          prefs.remove('account');
          print('account: ${json.encode(updatedAccount)}');
          prefs.setString('account', json.encode(updatedAccount));
        } catch (e) {
          print('Error decoding account data: $e');
        }

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Join seminar successfully'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Join seminar failed'),
          ),
        );
      }
    } catch (e) {
      if(e.toString().contains('Not enough money')) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Not enough money'),
          ),
        );
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
          Text(
            widget.description,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            softWrap: true,
            style: const TextStyle(
              fontSize: 16.0,
            ),
          ),
          const SizedBox(height: 5.0),
          if (widget.description.length > 100)
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                  PageTransition(
                    child: EventPostDetailScreen(
                      eventId: widget.seminarId,
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
                    ),
                    type: PageTransitionType.fade,
                    duration: const Duration(milliseconds: 300),
                  ),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    AppLocalizations.of(context)!.appReadMore,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
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
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(
                            'Join Seminar',
                            textAlign: TextAlign.center,
                          ),
                          surfaceTintColor: Colors.white,
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
                                Text(
                                  'Price: \$${widget.price}',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8.0),
                                Text(
                                  'Available: ${widget.activeSlot}/${widget.limitCustomer}',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
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
                                await joinSeminar();
                                Navigator.of(context).pop();
                              },
                              child: Text('Yes'),
                            ),
                          ],
                        );
                      });
                },
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  child: const Row(
                    children: [
                      Icon(Icons.add),
                      SizedBox(width: 4.0),
                      Text(
                        'Join Seminar',
                        style: TextStyle(
                          fontSize: 14.0,
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
}
