import 'package:flutter/material.dart';
import 'package:pagepals/models/reader_models/reader_profile_model.dart';
import 'package:pagepals/widgets/reader_info_widget/booking_badge.dart';
import 'package:pagepals/widgets/reader_info_widget/rating_row.dart';

class ReaderInfoWidget extends StatelessWidget {
  final ReaderProfile? reader;

  const ReaderInfoWidget({super.key, required this.reader});

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
          CircleAvatar(
            radius: 60,
            backgroundImage: NetworkImage(reader?.profile?.avatarUrl ??
                'https://th.bing.com/th/id/OIP.JBpgUJhTt8cI2V05-Uf53AHaG1?rs=1&pid=ImgDetMain'),
          ),
          const SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              BookingBadge(title: reader?.profile?.countryAccent ?? 'reader'),
              Text(
                reader?.profile?.nickname ?? 'reader',
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              ),
              // SizedBox(height: 10,),
              Text(
                '@${reader?.profile?.account?.username ?? 'reader'}',
                style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.black54),
              ),
              RatingRow(
                  rating: reader?.profile?.rating ?? 0,
                  reviews: reader?.profile?.totalOfReviews ?? '0')
            ],
          )
        ],
      ),
    );
  }
}
