import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pagepals/helpers/color_helper.dart';
import 'package:pagepals/screens/menu_item/bottom_nav_bar.dart';
import 'package:pagepals/screens/home_screen/home_screen.dart';
import 'package:pagepals/screens/order_screen/order_screen.dart';
import 'package:pagepals/screens/post_screen/post_screen.dart';
import 'package:pagepals/screens/reader_screen/reader_screen.dart';
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
      const ReaderScreen(),
      const SearchScreen(),
      const OrderScreen(),
      const PostScreen(),
    ];
  }

  List<BottomNavigationBarItem> get _navigatorItems {
    return [
      _bottomNavItem(
        icon: const Icon(UniconsLine.home_alt),
        activeIconPath: 'assets/icons/home-alt.svg',
        label: "Home",
      ),
      _bottomNavItem(
        icon: const Icon(UniconsLine.search),
        activeIconPath: 'assets/icons/search.svg',
        label: "Readers",
      ),
      _bottomNavItem(
        icon: const Icon(UniconsLine.book_alt),
        activeIconPath: 'assets/icons/book-alt.svg',
        label: "Books",
      ),
      _bottomNavItem(
        icon: const Icon(UniconsLine.schedule),
        activeIconPath: 'assets/icons/schedule.svg',
        label: "Booking",
      ),
      _bottomNavItem(
        icon: const Icon(UniconsLine.users_alt),
        activeIconPath: 'assets/icons/users-alt.svg',
        label: "PagePals",
      ),
    ];
  }

  BottomNavigationBarItem _bottomNavItem({
    required Icon icon,
    required String activeIconPath,
    required String label,
  }) {
    return BottomNavigationBarItem(
      icon: icon,
      activeIcon: SvgPicture.asset(
        height: 24,
        activeIconPath,
        color: ColorHelper.getColor(ColorHelper.green).withOpacity(0.7),
        // colorFilter: ColorFilter.mode(
        //   ColorHelper.getColor(ColorHelper.green).withOpacity(0.7),
        //   BlendMode.srcIn,
        // ),
      ),
      label: label,
    );
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
