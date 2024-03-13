import 'package:flutter/material.dart';
import 'package:pagepals/custom_icons.dart';
import 'package:pagepals/helpers/color_helper.dart';
import 'package:pagepals/screens/home_screen/notification_screen.dart';
import 'package:pagepals/screens/menu_item/bottom_nav_bar.dart';
import 'package:pagepals/screens/home_screen/home_screen.dart';
import 'package:pagepals/screens/order_screen/order_screen.dart';
import 'package:pagepals/screens/post_screen/post_screen.dart';
import 'package:pagepals/screens/search_screen/search_screen.dart';
import 'package:unicons/unicons.dart';

class MenuItemScreen extends StatefulWidget {
  const MenuItemScreen({Key? key}) : super(key: key);

  @override
  State<MenuItemScreen> createState() => _MenuItemScreenState();
}

class _MenuItemScreenState extends State<MenuItemScreen> {
  int _currentIndex = 0;
  bool _isDrawerOpen = false;

  @override
  void initState() {
    super.initState();
    _currentIndex = 0;
  }

  void _handleDrawerChange(bool isOpen) {
    setState(() {
      _isDrawerOpen = isOpen;
    });
  }

  List<Widget> _listScreens() {
    return [
      HomeScreen(onDrawerChange: _handleDrawerChange),
      const SearchScreen(),
      NotificationScreen(),
      const OrderScreen(),
      const PostScreen(),
    ];
  }

  List<BottomNavigationBarItem> get _navigatorItems {
    return [
      const BottomNavigationBarItem(
        icon: Icon(UniconsLine.home_alt),
        activeIcon: Icon(CustomIcons.home_alt),
        label: 'Home',
      ),
      const BottomNavigationBarItem(
        icon: Icon(UniconsLine.search),
        activeIcon: Icon(CustomIcons.search),
        label: 'Search',
      ),
      const BottomNavigationBarItem(
        icon: Icon(UniconsLine.bell),
        activeIcon: Icon(CustomIcons.bell),
        label: 'Notification',
      ),
      const BottomNavigationBarItem(
        icon: Icon(UniconsLine.schedule),
        activeIcon: Icon(CustomIcons.schedule),
        label: 'Booking',
      ),
      const BottomNavigationBarItem(
        icon: Icon(UniconsLine.users_alt),
        activeIcon: Icon(CustomIcons.users_alt),
        label: 'PagePals',
      ),
    ];
  }



  @override
  Widget build(BuildContext context) {
    final screens = _listScreens();

    return Scaffold(
      body: Stack(
        children: [
          screens[_currentIndex],
          if (!_isDrawerOpen)
            BottomNavBar(
              bottomBar: BottomNavigationBar(
                backgroundColor: Colors.white,
                currentIndex: _currentIndex,
                onTap: (index) => setState(() {
                  _currentIndex = index;
                }),
                items: _navigatorItems,
                selectedItemColor:
                    ColorHelper.getColor(ColorHelper.green).withOpacity(0.7),
                unselectedItemColor: Colors.grey,
                selectedFontSize: 10,
                unselectedFontSize: 10,
                // showUnselectedLabels: false,
                // showSelectedLabels: false,
                type: BottomNavigationBarType.fixed,
              ),
            ),
        ],
      ),
    );
  }
}
