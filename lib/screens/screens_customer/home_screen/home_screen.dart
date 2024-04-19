import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pagepals/helpers/color_helper.dart';
import 'package:pagepals/helpers/constant.dart';
import 'package:pagepals/helpers/space_helper.dart';
import 'package:pagepals/providers/google_signin_provider.dart';
import 'package:pagepals/screens/screens_authorization/signin_screen/signin_intro/signin_home.dart';
import 'package:pagepals/screens/screens_customer/home_screen/explore_screen.dart';
import 'package:pagepals/screens/screens_customer/home_screen/home_screen_drawer.dart';
import 'package:pagepals/screens/screens_customer/home_screen/popular_readers_widgets/popular_readers_column.dart';
import 'package:pagepals/screens/screens_customer/home_screen/search_bar_widgets/home_search_bar.dart';
import 'package:pagepals/screens/screens_customer/home_screen/welcome_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unicons/unicons.dart';

class HomeScreen extends StatefulWidget {
  final Function(bool) onDrawerChange;

  const HomeScreen({
    super.key,
    required this.onDrawerChange,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Declare GlobalKey for Scaffold
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      // Assign key to Scaffold
      drawer: const HomeScreenDrawer(),
      onDrawerChanged: widget.onDrawerChange,
      appBar: AppBar(
        surfaceTintColor: ColorHelper.getColor(ColorHelper.white),
        backgroundColor: ColorHelper.getColor(ColorHelper.white),
        title: Text(
          Constant.appName,
          style: GoogleFonts.openSans(
            color: ColorHelper.getColor(ColorHelper.normal),
            fontSize: SpaceHelper.space24,
            fontWeight: FontWeight.bold,
          ),
        ),
        automaticallyImplyLeading: false,
        leading: Container(
          margin: const EdgeInsets.fromLTRB(10, 10, 0, 10),
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.all(0),
              shape: const CircleBorder(),
              backgroundColor: Colors.green,
              side: const BorderSide(
                // color: Colors.grey[200]!,
                // width: 3,
                color: Colors.black45,
              ),
            ),
            child: const Icon(
              UniconsLine.subject,
              color: Colors.white,
            ),
            onPressed: () {
              // Open drawer using GlobalKey
              _scaffoldKey.currentState?.openDrawer();
            },
          ),
        ),
      ),
      body: SingleChildScrollView(
        controller: ScrollController(),
        physics: const AlwaysScrollableScrollPhysics(),
        child: const Center(
          child: Column(
            children: [
              HomeSearchBar(),
              WelcomeWidget(),
              PopularReadersColumn(),
              ExploreScreen(),
            ],
          ),
        ),
      ),
    );
  }
}
