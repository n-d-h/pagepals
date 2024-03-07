import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pagepals/helpers/color_helper.dart';
import 'package:pagepals/screens/home_screen/home_screen.dart';
import 'package:pagepals/screens/order_screen/order_screen.dart';
import 'package:pagepals/screens/personal_screen/personal_screen.dart';
import 'package:pagepals/screens/reader_screen/reader_screen.dart';
import 'package:pagepals/screens/search_screen/search_screen.dart';
import 'package:unicons/unicons.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

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
    return [
      const HomeScreen(),
      const ReaderScreen(),
      const SearchScreen(),
      const OrderScreen(),
      const PersonalScreen(),
    ];
  }

  final navigatorItems = [
    const BottomNavigationBarItem(
      icon: Icon(UniconsLine.home_alt),
      label: "Home",
    ),
    const BottomNavigationBarItem(
      icon: Icon(UniconsLine.search),
      label: "Readers",
    ),
    const BottomNavigationBarItem(
      icon: Icon(UniconsLine.book_alt),
      label: "Books",
    ),
    const BottomNavigationBarItem(
      icon: Icon(UniconsLine.schedule),
      label: "Booking",
    ),
    const BottomNavigationBarItem(
      icon: Icon(UniconsLine.user),
      label: "Profile",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final screens = listScreens();

    final bottomNavigationBarItems = navigatorItems;

    return Scaffold(
        body: screens[_currentIndex],
        bottomNavigationBar: Theme(
          data: ThemeData(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          child: Container(
              margin: const EdgeInsets.fromLTRB(12, 0, 12, 15),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12, spreadRadius: 2, blurRadius: 3),
                ],
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                child: BottomNavigationBar(
                  currentIndex: _currentIndex,
                  onTap: (index) => setState(() {
                    _currentIndex = index;
                  }),
                  items: bottomNavigationBarItems,
                  selectedItemColor: ColorHelper.getColor(ColorHelper.green),
                  unselectedItemColor: Colors.grey,
                  type: BottomNavigationBarType.fixed,
                ),
              )),
        ));
  }
}
