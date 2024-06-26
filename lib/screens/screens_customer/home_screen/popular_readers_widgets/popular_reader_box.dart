import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pagepals/helpers/color_helper.dart';
import 'package:pagepals/models/reader_models/popular_reader_model.dart';
import 'package:pagepals/screens/screens_customer/home_screen/popular_readers_widgets/favorite_button.dart';
import 'package:pagepals/screens/screens_customer/home_screen/video_player/intro_video.dart';
import 'package:pagepals/screens/screens_customer/profile_screen/overview_screen.dart';

class PopularReaderBox extends StatefulWidget {
  final PopularReader reader;
  final int index;
  final FavoriteButton iconButton;

  const PopularReaderBox({
    super.key,
    required this.reader,
    required this.index,
    required this.iconButton,
  });

  @override
  State<PopularReaderBox> createState() => PopularReaderBoxState();
}

class PopularReaderBoxState extends State<PopularReaderBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      margin: const EdgeInsets.fromLTRB(2, 10, 25, 10),
      padding: const EdgeInsets.only(top: 0, bottom: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 5),
          )
        ],
      ),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            PageTransition(
              child: ProfileOverviewScreen(
                readerId: widget.reader.id!,
              ),
              type: PageTransitionType.bottomToTop,
              duration: const Duration(milliseconds: 300),
            ),
          );
        },
        child: Stack(
          children: [
            Container(
              width: 300,
              height: 160,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
                image: DecorationImage(
                  image: NetworkImage(
                    widget.reader.account?.reader?.thumbnailUrl ??
                        'https://th.bing.com/th/id/OIP.JBpgUJhTt8cI2V05-Uf53AHaG1?rs=1&pid=ImgDetMain',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.fromLTRB(0, 161, 5, 0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(
                              left: 16,
                              right: 8,
                            ),
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: NetworkImage(
                                  widget.reader.avatarUrl ??
                                      'https://th.bing.com/th/id/OIP.JBpgUJhTt8cI2V05-Uf53AHaG1?rs=1&pid=ImgDetMain',
                                ),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.reader.nickname!,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                widget.reader.countryAccent!,
                                style: const TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      widget.iconButton,
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 0,
                    ),
                    child: Text(
                      widget.reader.description ??
                          'Đẹp trai, 6 múi, giọng trầm ấm, '
                              'với chất giọng miền Bắc cực chảy nước, '
                              'đọc được nhiều thể loại sách khác nhau. '
                              'Có thể đáp ứng mọi yêu cầu của User',
                      textAlign: TextAlign.start,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        height: 1.4,
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
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.star_rounded,
                        color: ColorHelper.getColor('#FFA800'),
                        size: 20,
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 2),
                        child: Text(
                          '${widget.reader.rating!}.0',
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 12,
                            color: ColorHelper.getColor('#FFA800'),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 1),
                        child: Text(
                          ' (${widget.reader.totalOfReviews})',
                          style: const TextStyle(
                            color: Colors.black26,
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
