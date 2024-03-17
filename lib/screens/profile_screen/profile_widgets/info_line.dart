import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pagepals/helpers/color_helper.dart';
import 'package:pagepals/models/reader_models/reader_profile_model.dart';
import 'package:pagepals/screens/reader_screen/reader_profile/reader_profile.dart';

class ProfileInfoLine extends StatelessWidget {
  final ReaderProfile? reader;
  const ProfileInfoLine({super.key, required this.reader});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      decoration: BoxDecoration(
          color:
          ColorHelper.getColor(ColorHelper.transparent)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                PageTransition(
                  child: const ReaderProfileScreen(),
                  type: PageTransitionType.bottomToTop,
                  duration: const Duration(milliseconds: 200),
                ),
              );
            },
            child: Container(
              margin:
              const EdgeInsets.only(left: 25, right: 10),
              width: 50,
              height: 50,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: NetworkImage(
                      'https://th.bing.com/th/id/OIP.JBpgUJhTt8cI2V05-Uf53AHaG1?rs=1&pid=ImgDetMain',
                    ),
                    fit: BoxFit.fitHeight),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                reader?.profile?.nickname ?? 'User name',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 2,
              ),
              Text(
                reader?.profile?.countryAccent ??
                    'Not set yet',
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: ColorHelper.getColor('#6C6C6C')),
              ),
            ],
          )
        ],
      ),
    );
  }
}
