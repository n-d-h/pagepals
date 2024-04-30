import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pagepals/models/booking_model.dart';
import 'package:pagepals/models/reader_models/reader_profile_model.dart';
import 'package:pagepals/screens/screens_customer/profile_screen/overview_screen.dart';
import 'package:pagepals/widgets/reader_info_widget/booking_badge.dart';
import 'package:pagepals/widgets/reader_info_widget/rating_row.dart';

class ReaderInfoWidget extends StatelessWidget {
  final ReaderProfile? reader;
  final Reader? readerInfo;

  const ReaderInfoWidget({super.key, this.reader, this.readerInfo});

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
      padding: const EdgeInsets.fromLTRB(5, 0, 5, 20),
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.black12, width: 1))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              if (readerInfo != null)
                Navigator.of(context).push(
                  PageTransition(
                    child: ProfileOverviewScreen(
                      readerId: readerInfo?.id ?? '',
                    ),
                    type: PageTransitionType.rightToLeft,
                    duration: const Duration(milliseconds: 300),
                  ),
                );
            },
            child: CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage(reader?.profile?.avatarUrl ??
                  readerInfo?.avatarUrl ??
                  'https://th.bing.com/th/id/OIP.JBpgUJhTt8cI2V05-Uf53AHaG1?rs=1&pid=ImgDetMain'),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              BookingBadge(
                  title: reader?.profile?.countryAccent ??
                      readerInfo?.countryAccent ??
                      'reader'),
              Text(
                reader?.profile?.nickname ?? readerInfo?.nickname ?? 'reader',
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              ),
              // SizedBox(height: 10,),
              Text(
                '@${reader?.profile?.account?.username ?? readerInfo?.account?.username ?? 'reader'}',
                style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.black54),
              ),
              RatingRow(
                  rating: reader?.profile?.rating ?? readerInfo?.rating ?? 0,
                  reviews: reader?.profile?.totalOfReviews ??
                      readerInfo?.totalOfReviews ??
                      0),
            ],
          )
        ],
      ),
    );
  }
}
