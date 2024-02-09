import 'package:flutter/material.dart';
import 'package:pagepals/helpers/space_helper.dart';
import 'package:pagepals/screens/reader_profile/reader_profile_about/reader_about_tabbar.dart';
import 'package:pagepals/screens/reader_profile/reader_profile_book/reader_book_tabbar.dart';
import 'package:pagepals/screens/reader_profile/reader_profile_review/reader_review_tabbar.dart';

class ReaderProfile extends StatefulWidget {
  const ReaderProfile({super.key});

  @override
  State<ReaderProfile> createState() => _ReaderProfileState();
}

class _ReaderProfileState extends State<ReaderProfile> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverAppBar(
                leading: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop(context);
                  },
                  splashRadius: 24,
                  icon: const Icon(
                    Icons.close,
                    color: Colors.black,
                  ),
                ),
                pinned: true,
                floating: true,
                stretch: true,
                snap: true,
                flexibleSpace: FlexibleSpaceBar(
                  stretchModes: const [
                    StretchMode.zoomBackground,
                    StretchMode.blurBackground,
                    StretchMode.fadeTitle,
                  ],
                  background: Container(
                    padding: const EdgeInsets.only(
                      top: SpaceHelper.space64,
                      bottom: SpaceHelper.space16,
                    ),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: AssetImage('assets/image_reader.png'),
                        ),
                        SizedBox(
                          height: SpaceHelper.space12,
                        ),
                        Text(
                          'Min Min',
                          style: TextStyle(
                            fontSize: SpaceHelper.fontSize14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: SpaceHelper.space4,
                        ),
                        Text(
                          '@builevanminnh',
                          style: TextStyle(
                            fontSize: SpaceHelper.fontSize12,
                          ),
                        ),
                        SizedBox(
                          height: SpaceHelper.space16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // star rating
                            Icon(
                              Icons.star,
                              color: Colors.yellow,
                            ),
                            Text(
                              '4.5',
                              style: TextStyle(
                                fontSize: SpaceHelper.fontSize14,
                              ),
                            ),
                            Text(
                              '(100)',
                              style: TextStyle(
                                fontSize: SpaceHelper.fontSize14,
                              ),
                            ),
                            SizedBox(
                              width: SpaceHelper.space8,
                            ),
                            Text(
                              'Northern dialect Vietnamese',
                              style: TextStyle(
                                fontSize: SpaceHelper.fontSize14,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                bottom: const MyTabBar(
                  color: Colors.white,
                  tabBar: TabBar(
                    tabs: [
                      Tab(text: 'About'),
                      Tab(text: 'Book'),
                      Tab(text: 'Review'),
                    ],
                  ),
                ),
                expandedHeight: 260.0,
              ),
            ];
          },
          body: const TabBarView(
            children: [
              ReaderAboutTabbar(),
              ReaderBookTabbar(),
              ReaderReviewTabbar(),
            ],
          ),
        ),
      ),
    );
  }
}

class MyTabBar extends StatelessWidget implements PreferredSizeWidget {
  final Color color;
  final TabBar tabBar;
  final double? elevation;

  const MyTabBar({
    Key? key,
    required this.color,
    required this.tabBar, this.elevation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: elevation ?? 4.0,
      color: color,
      child: tabBar,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
