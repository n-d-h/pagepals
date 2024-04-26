import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pagepals/helpers/color_helper.dart';
import 'package:unicons/unicons.dart';

class SeminarPostDetailScreen extends StatelessWidget {
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

  const SeminarPostDetailScreen({
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
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: const Text(
          'Seminar information',
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
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Text(
                description,
                style: const TextStyle(
                  fontSize: 16.0,
                ),
              ),
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
                    limitCustomer.toString(),
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
                    activeSlot.toString(),
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
          // join seminar
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
}
