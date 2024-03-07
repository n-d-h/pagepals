import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pagepals/helpers/color_helper.dart';
import 'package:pagepals/helpers/space_helper.dart';
import 'package:pagepals/screens/reader_screen/reader_profile/reader_profile_about/reader_about_tabbar.dart';
import 'package:pagepals/screens/reader_screen/reader_profile/reader_profile_book/reader_book_tabbar.dart';
import 'package:pagepals/screens/reader_screen/reader_profile/reader_profile_review/reader_review_tabbar.dart';

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
                backgroundColor: Colors.white,
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
                      top: 50,
                      bottom: SpaceHelper.space16,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const CircleAvatar(
                          radius: 45,
                          backgroundImage:
                              AssetImage('assets/image_reader.png'),
                        ),
                        const SizedBox(height: SpaceHelper.space12),
                        const Text(
                          'Bùi Lễ Văn Minh',
                          style: TextStyle(
                            fontSize: SpaceHelper.fontSize14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text(
                          '@minmin',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: SpaceHelper.fontSize12,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // star rating
                            Icon(
                              Icons.star_rounded,
                              color: ColorHelper.getColor('#FFA800'),
                              size: 18,
                            ),
                            const SizedBox(width: 3),
                            Text(
                              '4.5',
                              style: TextStyle(
                                color: ColorHelper.getColor('#FFA800'),
                                fontSize: SpaceHelper.fontSize14,
                                fontWeight: FontWeight.w600
                              ),
                            ),
                            const SizedBox(width: 3),
                            Text(
                              '(100)',
                              style: TextStyle(
                                color: Colors.grey.withOpacity(0.5),
                                fontSize: SpaceHelper.fontSize14,
                              ),
                            ),
                            const SizedBox(
                              width: SpaceHelper.space8,
                            ),
                            Text(
                              'Northern dialect Vietnamese',
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.7),
                                fontSize: SpaceHelper.fontSize14,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                      ],
                    ),
                  ),
                ),
                bottom: MyTabBar(
                  elevation: 0.5,
                  color: Colors.white,
                  tabBar: TabBar(
                    indicatorColor: ColorHelper.getColor(ColorHelper.green),
                    labelColor: ColorHelper.getColor(ColorHelper.green),
                    dividerColor: Colors.white,
                    labelStyle: GoogleFonts.openSans(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    unselectedLabelColor: Colors.grey.shade400,
                    // padding: EdgeInsets.symmetric(vertical: 10),
                    tabs: const [
                      Tab(text: 'About'),
                      Tab(text: 'Book'),
                      Tab(text: 'Reviews'),
                    ],
                  ),
                ),
                expandedHeight: 265.0,
                // collapsedHeight: 0,
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
    required this.tabBar,
    this.elevation,
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
