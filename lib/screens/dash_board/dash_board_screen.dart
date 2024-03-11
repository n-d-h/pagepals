import 'package:flutter/material.dart';
import 'package:pagepals/helpers/color_helper.dart';
import 'package:pagepals/screens/home_screen/home_screen.dart';
import 'package:pagepals/screens/order_screen/order_screen.dart';
import 'package:pagepals/screens/personal_screen/personal_screen.dart';
import 'package:pagepals/screens/reader_screen/reader_screen.dart';
import 'package:pagepals/screens/search_screen/search_screen.dart';
import 'package:unicons/unicons.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _currentIndex = 0;
  }

  List<Widget> listScreens() {
    return const [
      HomeScreen(),
      ReaderScreen(),
      SearchScreen(),
      OrderScreen(),
      PersonalScreen(),
    ];
  }

  final navigatorItems = const [
    BottomNavigationBarItem(
      icon: Icon(UniconsLine.home_alt),
      label: "Home",
    ),
    BottomNavigationBarItem(
      icon: Icon(UniconsLine.search),
      label: "Readers",
    ),
    BottomNavigationBarItem(
      icon: Icon(UniconsLine.book_alt),
      label: "Books",
    ),
    BottomNavigationBarItem(
      icon: Icon(UniconsLine.schedule),
      label: "Booking",
    ),
    BottomNavigationBarItem(
      icon: Icon(UniconsLine.user),
      label: "Profile",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final screens = listScreens();

    return Scaffold(
      body: Stack(
        children: [
          screens[_currentIndex],
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Theme(
              data: ThemeData(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
              ),
              child: Container(
                margin: const EdgeInsets.fromLTRB(12, 0, 12, 15),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      spreadRadius: 2,
                      blurRadius: 3,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  child: BottomNavigationBar(
                    backgroundColor: Colors.white,
                    currentIndex: _currentIndex,
                    onTap: (index) => setState(() {
                      _currentIndex = index;
                    }),
                    items: navigatorItems,
                    selectedItemColor: ColorHelper.getColor(ColorHelper.green),
                    unselectedItemColor: Colors.grey,
                    type: BottomNavigationBarType.fixed,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
