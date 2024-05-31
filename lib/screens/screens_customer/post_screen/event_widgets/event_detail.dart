import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pagepals/helpers/color_helper.dart';
import 'package:pagepals/models/authen_models/account_model.dart';
import 'package:pagepals/models/book_models/book_model.dart';
import 'package:pagepals/screens/screens_customer/book_screen/book_detail_widgets/book_description.dart';
import 'package:pagepals/screens/screens_customer/book_screen/book_detail_widgets/book_image_widget.dart';
import 'package:pagepals/screens/screens_customer/book_screen/book_detail_widgets/book_info_widget.dart';
import 'package:pagepals/screens/screens_customer/post_screen/event_widgets/show_html_widget.dart';
import 'package:pagepals/services/authen_service.dart';
import 'package:pagepals/services/event_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unicons/unicons.dart';

class EventPostDetailScreen extends StatelessWidget {
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

  const EventPostDetailScreen({
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

  Future<void> joinSeminar(BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? account = prefs.getString('account');
      AccountModel? accountModel = AccountModel.fromJson(jsonDecode(account!));
      String customerId = accountModel.customer?.id ?? '';

      bool results = await EventService.bookEvent(customerId, eventId);
      if (results) {
        onEventBookedDone(true);

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

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Join event successfully'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Join event failed'),
          ),
        );
      }
    } catch (e) {
      if (e.toString().contains('Not enough money')) {
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
    String? authors = book.authors?.map((e) => e.name ?? '').join(', ');
    String? categories = book.categories?.map((e) => e.name ?? '').join(', ');

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        surfaceTintColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'Event information',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundImage: NetworkImage(hostAvatarUrl),
                  ),
                  const SizedBox(width: 12.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          seminarTitle,
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
                                text: hostName,
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
                                text: date,
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
                                text: time,
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
            ),
            const SizedBox(height: 8.0),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: const Text(
                'Book information',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 10),
                  BookImage(url: book.thumbnailUrl),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: Text(
                            textAlign: TextAlign.center,
                            book.title ?? 'Book title',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        BookInfo(title: 'Authors: ', info: authors),
                        const SizedBox(height: 20),
                        BookInfo(title: 'Categories: ', info: categories),
                        const SizedBox(height: 20),
                        BookDescription(description: book.description),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8.0),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: const Text(
                'Event information',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            description.length < 100
                ? Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Text(
                      description,
                      style: GoogleFonts.lexend(
                        fontSize: 16.0,
                      ),
                    ),
                  )
                : ShowMoreHtmlWidget(
                    htmlContent: description,
                    isShowShortText: false,
                    maxLines: 3,
                  ),
            const SizedBox(height: 8.0),
            Image.network(
              bannerImageUrl,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            // show the price and limit customer here
            const SizedBox(height: 8.0),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Icon(
                          UniconsLine.usd_circle,
                        ),
                        const SizedBox(width: 10.0),
                        Text(
                          'Price: ',
                          style: GoogleFonts.lexend(
                            fontSize: 16.0,
                            color: ColorHelper.getColor(ColorHelper.green),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    '${price.toString()} pals',
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8.0),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Icon(
                          UniconsLine.users_alt,
                        ),
                        const SizedBox(width: 10.0),
                        Text(
                          'Number of Customer: ',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: ColorHelper.getColor(ColorHelper.green),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    '${limitCustomer} slots',
                    style: GoogleFonts.lexend(
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8.0),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Icon(
                          UniconsLine.user,
                        ),
                        const SizedBox(width: 10.0),
                        Text(
                          'Active Slot: ',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: ColorHelper.getColor(ColorHelper.green),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    '${activeSlot} slots',
                    style: GoogleFonts.lexend(
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: InkWell(
        onTap: () {
          handleJoinSeminar(context);
        },
        child: Container(
          height: 50.0,
          width: double.infinity,
          margin: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: ColorHelper.getColor(ColorHelper.green),
          ),
          child: Center(
            child: Text(
              'Join Seminar',
              style: GoogleFonts.lexend(
                fontSize: 16.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void handleJoinSeminar(BuildContext context) {
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
                Row(
                  children: [
                    Text(
                      'Price: ',
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                    Text(
                      '${price} pals',
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
                      '${activeSlot} slots',
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
                await joinSeminar(context);
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
