import 'package:flutter/material.dart';
import 'package:pagepals/custom_icons.dart';
import 'package:pagepals/helpers/color_helper.dart';
import 'package:pagepals/screens/notification_screen/notification_screen.dart';
import 'package:pagepals/screens/menu_item/bottom_nav_bar.dart';
import 'package:pagepals/screens/home_screen/home_screen.dart';
import 'package:pagepals/screens/order_screen/order_screen.dart';
import 'package:pagepals/screens/post_screen/post_screen.dart';
// import 'package:pagepals/screens/search_screen/search_screen.dart';
import 'package:unicons/unicons.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
      // const SearchScreen(),
      const NotificationScreen(),
      const OrderScreen(),
      const PostScreen(),
    ];
  }

  List<BottomNavigationBarItem> get _navigatorItems {
    return [
      BottomNavigationBarItem(
        icon: const Icon(UniconsLine.home_alt),
        activeIcon: const Icon(CustomIcons.home_alt),
        label: AppLocalizations.of(context)!.appHome,
      ),
      // BottomNavigationBarItem(
      //   icon: const Icon(UniconsLine.search),
      //   activeIcon: const Icon(CustomIcons.search),
      //   label: AppLocalizations.of(context)!.appSearch,
      // ),
      BottomNavigationBarItem(
        icon: const Icon(Icons.notifications_none),
        activeIcon: const Icon(Icons.notifications),
        label: AppLocalizations.of(context)!.appNotification,
      ),
      BottomNavigationBarItem(
        icon: const Icon(UniconsLine.schedule),
        activeIcon: const Icon(CustomIcons.schedule),
        label: AppLocalizations.of(context)!.appBooking,
      ),
      BottomNavigationBarItem(
        icon: const Icon(UniconsLine.users_alt),
        activeIcon: const Icon(CustomIcons.users_alt),
        label: AppLocalizations.of(context)!.appPagePals,
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
                iconSize: 24,
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
