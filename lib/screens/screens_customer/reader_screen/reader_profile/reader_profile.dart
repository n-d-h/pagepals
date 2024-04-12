import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pagepals/helpers/color_helper.dart';
import 'package:pagepals/helpers/space_helper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pagepals/models/comment_model.dart';
import 'package:pagepals/models/reader_models/reader_profile_model.dart';
import 'package:pagepals/screens/screens_customer/reader_screen/reader_profile/reader_profile_about/reader_about_tabbar.dart';
import 'package:pagepals/screens/screens_customer/reader_screen/reader_profile/reader_profile_book/reader_book_tabbar.dart';
import 'package:pagepals/screens/screens_customer/reader_screen/reader_profile/reader_profile_review/reader_review_tabbar.dart';
import 'package:pagepals/services/reader_service.dart';
import 'package:pagepals/widgets/reader_info_widget/booking_badge.dart';
import 'package:pagepals/widgets/reader_info_widget/rating_row.dart';

class ReaderProfileScreen extends StatefulWidget {
  final String readerId;

  const ReaderProfileScreen({super.key, required this.readerId});

  @override
  State<ReaderProfileScreen> createState() => _ReaderProfileState();
}

class _ReaderProfileState extends State<ReaderProfileScreen> {
  ReaderProfile reader = ReaderProfile();
  CommentModel? commentModel;

  @override
  void initState() {
    super.initState();
    getReaderProfile(widget.readerId);
    getListReaderComment(widget.readerId);
  }

  Future<void> getReaderProfile(String id) async {
    var data = await ReaderService.getReaderProfile(id);
    setState(() {
      reader = data!;
    });
  }

  Future<void> getListReaderComment(String id) async {
    var result = await ReaderService.getListReaderComment(id, 0, 10);
    setState(() {
      commentModel = result;
    });
  }


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverAppBar(
                surfaceTintColor: Colors.white,
                backgroundColor: Colors.white,
                leading: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop(context);
                  },
                  splashRadius: 24,
                  icon: const Icon(
                    Icons.arrow_back_ios,
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
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(0.6), BlendMode.darken),
                        image: const AssetImage('assets/reading_book.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    padding: const EdgeInsets.only(
                      top: 50,
                      bottom: SpaceHelper.space16,
                    ),
                    child: Container(
                      // margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                      padding: const EdgeInsets.fromLTRB(20, 35, 10, 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 60,
                            backgroundImage: NetworkImage(
                              reader.profile?.avatarUrl ??
                                  'https://via.placeholder.com/150',
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
                                  title: reader.profile?.countryAccent ??
                                      'reader'),
                              Text(
                                reader.profile?.nickname ?? 'reader',
                                style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                              ),
                              // SizedBox(height: 10,),
                              Text(
                                '@${reader.profile?.account?.username ?? 'reader'}',
                                style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                              ),
                              RatingRow(
                                rating: reader.profile?.rating ?? 0,
                                reviews: reader.profile?.totalOfReviews ?? 0,
                                color: Colors.white,
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                bottom: MyTabBar(
                  elevation: 0.5,
                  color: Colors.white,
                  tabBar: TabBar(
                    indicatorColor: ColorHelper.getColor(ColorHelper.green),
                    labelColor: ColorHelper.getColor(ColorHelper.green),
                    indicatorSize: TabBarIndicatorSize.tab,
                    dividerColor: Colors.white,
                    labelStyle: GoogleFonts.lexend(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                    unselectedLabelColor: Colors.grey.shade400,
                    tabs: [
                      Tab(text: AppLocalizations.of(context)!.appAbout),
                      Tab(text: AppLocalizations.of(context)!.appBooks),
                      Tab(text: AppLocalizations.of(context)!.appReviews),
                    ],
                  ),
                ),
                expandedHeight: 240.0,
              ),
            ];
          },
          body: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            children: [
              ReaderAboutTabbar(
                videoUrl: reader.profile?.introductionVideoUrl ?? '',
              ),
              const ReaderBookTabbar(),
              ReaderReviewTabbar(
                commentModel: commentModel,
                reader: reader,
              ),
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
