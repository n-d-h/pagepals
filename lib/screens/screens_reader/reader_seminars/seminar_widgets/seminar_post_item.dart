import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pagepals/helpers/color_helper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pagepals/models/authen_models/account_model.dart';
import 'package:pagepals/screens/screens_customer/post_screen/seminar_widgets/seminar_post_detail.dart';
import 'package:pagepals/screens/screens_reader/reader_seminars/reader_seminar_edit_screen.dart';
import 'package:pagepals/services/seminar_service.dart';

class SeminarPostItem extends StatefulWidget {
  final String id;
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
  final int duration;
  final String bookTitle;
  final Function() onDeleteDone;
  final Function() onUpdateDone;
  final AccountModel? accountModel;

  const SeminarPostItem({
    Key? key,
    required this.id,
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
    required this.duration,
    required this.bookTitle,
    required this.onDeleteDone,
    required this.onUpdateDone,
    this.accountModel,
  }) : super(key: key);

  @override
  _SeminarPostItemState createState() => _SeminarPostItemState();
}

class _SeminarPostItemState extends State<SeminarPostItem> {
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
              InkWell(
                onTap: () async {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Delete Seminar'),
                        content: Text(
                          'Are you sure you want to delete this seminar?',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () async {
                              String seminarId = widget.id;
                              await SeminarService.deleteSeminar(seminarId);
                              widget.onDeleteDone();
                              Navigator.pop(context, true);
                            },
                            child: Text('Delete'),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Container(
                  height: 50,
                  width: 70,
                  padding: const EdgeInsets.only(right: 8, left: 8),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Center(
                    child: Text(
                      'Delete',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8.0),
              InkWell(
                onTap: () async {
                  Navigator.push(
                      context,
                      PageTransition(
                        child: ReaderSeminarEditScreen(
                          onUpdateDone: widget.onUpdateDone,
                          accountModel: widget.accountModel,
                          id: widget.id,
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
                          duration: widget.duration,
                          bookTitle: widget.bookTitle,
                        ),
                        type: PageTransitionType.rightToLeft,
                      )
                  );
                },
                child: Container(
                  height: 50,
                  width: 70,
                  padding: const EdgeInsets.only(right: 8, left: 8),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Center(
                    child: Text(
                      'Update',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
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
                      seminarId: widget.id,
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
        ],
      ),
    );
  }
}
