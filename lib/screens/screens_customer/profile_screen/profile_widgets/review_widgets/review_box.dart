import 'package:flutter/material.dart';
import 'package:pagepals/helpers/color_helper.dart';

class ProfileReviewBox extends StatelessWidget {
  const ProfileReviewBox({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          // itemCount: int.tryParse(reader?.profile?.totalOfReviews ?? '') ?? 0,
          itemCount: 5,
          itemBuilder: (BuildContext context, int index) {
            return Container(
                width: 300,
                margin: const EdgeInsets.fromLTRB(2, 10, 25, 10),
                padding: const EdgeInsets.symmetric(
                  horizontal: 0,
                  vertical: 15,
                ),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black45,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      )
                    ]),
                child: InkWell(
                    onTap: () {},
                    child: Stack(
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(
                                      left: 16,
                                      right: 8,
                                    ),
                                    width: 35,
                                    height: 35,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          image:
                                              AssetImage('assets/google.png'),
                                          fit: BoxFit.fitHeight),
                                    ),
                                  ),
                                  const Text(
                                    'User name',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 3),
                                child: const Text(
                                  'Giọng đọc hay, lôi cuốn, '
                                  'nghe không biết chán, '
                                  'đẹp trai, có múi, da ngăm'
                                  ' giọng trầm đeo kính cận, lịch sự, '
                                  'take care tốt khách hàng',
                                  textAlign: TextAlign.start,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    // wordSpacing: 1,
                                    height: 2.2,
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.bottomCenter,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.star_rounded,
                                    color: ColorHelper.getColor('#FFA800'),
                                    size: 16,
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(left: 2),
                                    child: const Text(
                                      '5.0',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12),
                                    ),
                                  )
                                ],
                              ),
                              const Text(
                                'January, 24',
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w300),
                              )
                            ],
                          ),
                        )
                      ],
                    )));
          }),
    );
  }
}
