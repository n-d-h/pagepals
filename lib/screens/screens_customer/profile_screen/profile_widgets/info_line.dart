import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pagepals/helpers/color_helper.dart';
import 'package:pagepals/models/reader_models/reader_profile_model.dart';
import 'package:pagepals/screens/screens_customer/reader_screen/reader_profile/reader_profile.dart';
import 'dart:math' as math;

class ProfileInfoLine extends StatelessWidget {
  final ReaderProfile? reader;
  final Function() pauseVideo;

  const ProfileInfoLine(
      {super.key, required this.reader, required this.pauseVideo});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      decoration:
          BoxDecoration(color: ColorHelper.getColor(ColorHelper.transparent)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  pauseVideo();
                  Navigator.push(
                    context,
                    PageTransition(
                      child: ReaderProfileScreen(
                        readerId: reader!.profile!.id!,
                      ),
                      type: PageTransitionType.rightToLeft,
                      duration: const Duration(milliseconds: 300),
                    ),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.only(left: 25, right: 10),
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: NetworkImage(
                          reader?.profile?.avatarUrl ??
                          'https://th.bing.com/th/id/OIP.JBpgUJhTt8cI2V05-Uf53AHaG1?rs=1&pid=ImgDetMain',
                        ),
                        fit: BoxFit.fill),
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
                    reader?.profile?.countryAccent ?? 'Not set yet',
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: ColorHelper.getColor('#6C6C6C')),
                  ),
                ],
              )
            ],
          ),
          Container(
            height: 40,
            width: 40,
            padding: const EdgeInsets.only(left: 1),
            decoration: BoxDecoration(
              color: ColorHelper.getColor(ColorHelper.white),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: ColorHelper.getColor('#6C6C6C').withOpacity(0.3),
                width: 2,
              ),
            ),
            margin: const EdgeInsets.only(right: 25),
            child: IconButton(
              splashColor: Colors.grey,
              onPressed: () {
                pauseVideo();
                Navigator.push(
                  context,
                  PageTransition(
                    child: ReaderProfileScreen(
                      readerId: reader!.profile!.id!,
                    ),
                    type: PageTransitionType.rightToLeft,
                    duration: const Duration(milliseconds: 300),
                  ),
                );
              },
              icon: Icon(
                Icons.arrow_forward_ios,
                size: 20,
                color: ColorHelper.getColor('#6C6C6C'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
