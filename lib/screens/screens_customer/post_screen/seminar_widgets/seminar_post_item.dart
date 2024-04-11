import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pagepals/helpers/color_helper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pagepals/screens/screens_customer/post_screen/seminar_widgets/seminar_post_detail.dart';

class SeminarPostItem extends StatefulWidget {
  final String hostName;
  final String seminarTitle;
  final String date;
  final String time;
  final String description;
  final String hostAvatarUrl;
  final String bannerImageUrl;

  const SeminarPostItem({
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
  _SeminarPostItemState createState() => _SeminarPostItemState();
}

class _SeminarPostItemState extends State<SeminarPostItem> {
  int interestedCount = 0;
  bool interested = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
      margin: const EdgeInsets.only(bottom: 10.0),
      color: Colors.white,
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
                    child: SeminarPostDetailScreen(
                      hostName: widget.hostName,
                      seminarTitle: widget.seminarTitle,
                      date: widget.date,
                      time: widget.time,
                      description: widget.description,
                      hostAvatarUrl: widget.hostAvatarUrl,
                      bannerImageUrl: widget.bannerImageUrl,
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    interested = !interested;
                    interested ? interestedCount++ : interestedCount--;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      interested
                          ? const Icon(
                              Icons.star_rounded,
                              color: Colors.orange,
                            )
                          : const Icon(Icons.star_border_rounded),
                      const SizedBox(width: 4.0),
                      Text(
                        '$interestedCount Interested',
                        style: const TextStyle(
                          fontSize: 14.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  // Add action to join the seminar
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
