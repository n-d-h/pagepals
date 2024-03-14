import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pagepals/helpers/color_helper.dart';
import 'package:pagepals/helpers/constant.dart';
import 'package:pagepals/helpers/space_helper.dart';
import 'package:pagepals/screens/home_screen/explore_screen.dart';
import 'package:pagepals/screens/home_screen/home_screen_drawer.dart';
import 'package:pagepals/screens/home_screen/search_bar_widgets/home_search_bar.dart';
import 'package:pagepals/screens/notification_screen/notification_screen.dart';
import 'package:pagepals/screens/home_screen/popular_readers_widgets/popular_readers_column.dart';
import 'package:pagepals/screens/home_screen/welcome_widget.dart';
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
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      // Assign key to Scaffold
      drawer: const HomeScreenDrawer(),
      onDrawerChanged: widget.onDrawerChange,
      appBar: AppBar(
        backgroundColor: ColorHelper.getColor(ColorHelper.lightActive),
        title: const Text(
          Constant.appName,
          style: TextStyle(
            color: Colors.black,
            fontSize: SpaceHelper.space24,
            fontWeight: FontWeight.bold,
          ),
        ),
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(
            UniconsSolid.bars,
            color: Colors.black,
          ),
          onPressed: () {
            // Open drawer using GlobalKey
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                PageTransition(
                  child: const NotificationScreen(),
                  type: PageTransitionType.bottomToTop,
                  duration: const Duration(milliseconds: 300),
                ),
              );
            },
            icon: const Icon(
              Icons.notifications_none_outlined,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        controller: ScrollController(),
        physics: const BouncingScrollPhysics(),
        child: const Center(
          child: Column(
            children: [
              HomeSearchBar(),
              WelcomeWidget(),
              PopularReadersColumn(),
              ExploreScreen(),
              SizedBox(
                height: 70,
              )
            ],
          ),
        ),
      ),
    );
  }
}
