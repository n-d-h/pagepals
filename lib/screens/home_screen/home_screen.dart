import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pagepals/helpers/color_helper.dart';
import 'package:pagepals/helpers/constant.dart';
import 'package:pagepals/helpers/space_helper.dart';
import 'package:pagepals/screens/home_screen/explore_screen.dart';
import 'package:pagepals/screens/home_screen/notification_screen.dart';
import 'package:pagepals/screens/home_screen/popular_reader_widget.dart';
import 'package:pagepals/screens/home_screen/welcome_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              WelcomeWidget(),
              PopularReaderWidget(),
              ExploreScreen(),
            ],
          ),
        ),
      ),
    );
  }
}
