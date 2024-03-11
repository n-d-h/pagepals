import 'package:flutter/material.dart';
import 'package:pagepals/helpers/color_helper.dart';
import 'package:pagepals/screens/dash_board/bottom_nav_bar.dart';
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
  bool isDrawerOpen = false;

  @override
  void initState() {
    super.initState();
    _currentIndex = 0;
  }

  List<Widget> listScreens() {
    return [
      HomeScreen(
        onDrawerChange: (bool isOpen) {
          setState(() {
            isDrawerOpen = isOpen;
          });
        },
      ),
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
          if (!isDrawerOpen)
            BottomNavBar(
              bottomBar: BottomNavigationBar(
                backgroundColor: Colors.white,
                currentIndex: _currentIndex,
                onTap: (index) =>
                    setState(() {
                      _currentIndex = index;
                    }),
                items: navigatorItems,
                selectedItemColor: ColorHelper.getColor(ColorHelper.green),
                unselectedItemColor: Colors.grey,
                type: BottomNavigationBarType.fixed,
              ),
            ),
        ],
      ),
    );
  }
}


