import 'package:flutter/material.dart';
import 'package:pagepals/helpers/color_helper.dart';
import 'package:pagepals/screens/home_screen/home_screen.dart';
import 'package:pagepals/screens/message_screen/message_screen.dart';
import 'package:pagepals/screens/order_screen/order_screen.dart';
import 'package:pagepals/screens/personal_screen/personal_screen.dart';
import 'package:pagepals/screens/search_screen/search_screen.dart';
import 'package:pagepals/screens/signin_screen/signin_screen.dart';

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
      const MessageScreen(),
      const SearchScreen(),
      const OrderScreen(),
      const PersonalScreen(),
    ];
  }

  final navigatorItems = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: "Home",
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.message),
      label: "Message",
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.search_rounded),
      label: "Search",
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.task),
      label: "Order",
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.person_2_rounded),
      label: "Profile",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final screens = listScreens();
    final bottomNavigationBarItems = navigatorItems;

    return Scaffold(
      body: screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() {
          _currentIndex = index;
        }),
        items: bottomNavigationBarItems,
        selectedItemColor: ColorHelper.getColor(ColorHelper.normal),
        unselectedItemColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
      ),
    );
  }
}
