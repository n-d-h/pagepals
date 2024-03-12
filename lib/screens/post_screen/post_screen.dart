import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pagepals/helpers/color_helper.dart';
import 'package:pagepals/screens/post_screen/message_screen/message_screen.dart';
import 'package:pagepals/screens/post_screen/post_tab/new_feed_tabbar.dart';
import 'package:pagepals/screens/post_screen/post_item.dart';
import 'package:pagepals/screens/post_screen/post_status_screen.dart';
import 'package:pagepals/screens/post_screen/post_tab/seminar_tabbar.dart';
import 'package:unicons/unicons.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    int selectedIndex = 0;

    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverAppBar(
              backgroundColor: Colors.white,
              title: const Text(
                'PagePals and Friends',
                style: TextStyle(
                  color: Colors.blueAccent,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -1.2,
                ),
              ),
              automaticallyImplyLeading: false,
              centerTitle: false,
              floating: true,
              stretch: true,
              pinned: true,
              surfaceTintColor: Colors.white,
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: IconButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        PageTransition(
                          child: const MessageScreen(),
                          type: PageTransitionType.bottomToTop,
                          duration: const Duration(milliseconds: 500),
                        ),
                      );
                    },
                    splashRadius: 24,
                    icon: const Icon(
                      UniconsLine.comment_lines,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            SliverToBoxAdapter(
              child: DefaultTabController(
                length: 2,
                child: Column(
                  children: [
                    TabBar(
                      labelColor: ColorHelper.getColor(ColorHelper.green),
                      indicatorColor: ColorHelper.getColor(ColorHelper.green),
                      indicatorSize: TabBarIndicatorSize.tab,
                      labelStyle: GoogleFonts.lexend(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                      unselectedLabelColor: Colors.grey.shade400,
                      tabs: [
                        Tab(
                          text: AppLocalizations.of(context)!.appNewFeed,
                        ),
                        Tab(
                          text: AppLocalizations.of(context)!.appSeminar,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.8,
                      width: double.infinity,
                      child: const TabBarView(
                        children: [
                          NewFeedTabbar(),
                          SeminarTabbar(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
