import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pagepals/custom_icons.dart';
import 'package:pagepals/helpers/color_helper.dart';
import 'package:unicons/unicons.dart';

class SeminarPostDetailScreen extends StatelessWidget {
  final String hostName;
  final String seminarTitle;
  final String date;
  final String time;
  final String description;
  final String hostAvatarUrl;
  final String bannerImageUrl;

  const SeminarPostDetailScreen({
    Key? key,
    required this.hostName,
    required this.seminarTitle,
    required this.time,
    required this.description,
    required this.hostAvatarUrl,
    required this.bannerImageUrl,
    required this.date,
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
          ],
        ),
      ),
    );
  }
}
