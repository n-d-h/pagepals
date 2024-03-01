import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pagepals/helpers/color_helper.dart';
import 'package:pagepals/helpers/space_helper.dart';
import 'package:pagepals/screens/profile_screen/overview_screen.dart';
import 'package:pagepals/models/popular_reader_model.dart';
import 'package:pagepals/services/reader_service.dart';

class PopularReaderWidget extends StatefulWidget {
  const PopularReaderWidget({super.key});

  @override
  State<PopularReaderWidget> createState() => _PopularReaderWidgetState();
}

class _PopularReaderWidgetState extends State<PopularReaderWidget> {
  late List<bool> _clickedList;
  List<PopularReader> readers = [];

  @override
  void initState() {
    super.initState();
    _clickedList = [];
    getListPopularReaders();
  }

  Future<void> getListPopularReaders() async {
    var list = await ReaderService.getPopularReaders();
    setState(() {
      readers = list;
      _clickedList = List.generate(readers.length, (index) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * SpaceHelper.spaceNineTenths,
      margin: const EdgeInsets.fromLTRB(24, 0, 24, 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Popular Readers',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'See All',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: ColorHelper.getColor(ColorHelper.green),
                    fontSize: 14,
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 320,
            child: readers.isEmpty
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: readers.length,
                    itemBuilder: (context, index) {
                      var reader = readers[index];
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
                                child: ProfileOverviewScreen(readerId: reader.id!,),
                                type: PageTransitionType.bottomToTop,
                                duration: const Duration(milliseconds: 300),
                              ),
                            );
                          },
                          child: Stack(
                            children: [
                              Container(
                                alignment: Alignment.topCenter,
                                height: 160,
                                decoration: const BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(12),
                                    topRight: Radius.circular(12),
                                  ),
                                ),
                              ),
                              Container(
                                alignment: Alignment.topLeft,
                                margin:
                                    const EdgeInsets.fromLTRB(0, 159, 16, 0),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
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
                                              decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                    'assets/google.png',
                                                  ),
                                                  fit: BoxFit.fitHeight,
                                                ),
                                              ),
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  reader.nickname!,
                                                  style: const TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(
                                                  reader.countryAccent!,
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
                                        IconButton(
                                          onPressed: () {
                                            setState(() {
                                              _clickedList[index] =
                                                  !_clickedList[index];
                                            });
                                          },
                                          icon: Icon(
                                            _clickedList[index]
                                                ? Icons.favorite
                                                : Icons.favorite_border_sharp,
                                            size: 25,
                                            color: _clickedList[index]
                                                ? Colors.red
                                                : Colors.black12,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 0,
                                      ),
                                      child: const Text(
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
                                  horizontal: 16,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.star_rounded,
                                          color:
                                              ColorHelper.getColor('#FFA800'),
                                          size: 20,
                                        ),
                                        Container(
                                          margin:
                                              const EdgeInsets.only(left: 2),
                                          child: Text(
                                            '${reader.rating!}.0',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w900,
                                              fontSize: 12,
                                              color: ColorHelper.getColor(
                                                  '#FFA800'),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin:
                                              const EdgeInsets.only(left: 1),
                                          child: Text(
                                            ' (${reader.totalOfReviews})',
                                            style: const TextStyle(
                                              color: Colors.black26,
                                              fontSize: 10,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    RichText(
                                      text: const TextSpan(
                                        text: 'From   ',
                                        style: TextStyle(
                                          color: Colors.black26,
                                          fontSize: 9,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: "15000 VND",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
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
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
