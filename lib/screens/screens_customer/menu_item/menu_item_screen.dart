import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pagepals/custom_icons.dart';
import 'package:pagepals/screens/screens_customer/home_screen/home_screen.dart';
import 'package:pagepals/screens/screens_customer/menu_item/bottom_tab_bar.dart';
import 'package:pagepals/screens/screens_customer/notification_screen/notification_screen.dart';
import 'package:pagepals/screens/screens_customer/order_screen/order_screen.dart';
import 'package:pagepals/screens/screens_customer/post_screen/post_screen.dart';
import 'package:pagepals/screens/screens_customer/search_screen/search_screen.dart';
import 'package:unicons/unicons.dart';

class MenuItemScreen extends StatefulWidget {
  final int? index;

  const MenuItemScreen({Key? key, this.index}) : super(key: key);

  @override
  State<MenuItemScreen> createState() => _MenuItemScreenState();
}

class _MenuItemScreenState extends State<MenuItemScreen> {
  int _currentIndex = 0;
  bool _isDrawerOpen = false;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.index ?? 0;
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
      BottomNavigationBarItem(
        icon: const Icon(UniconsLine.search),
        activeIcon: const Icon(CustomIcons.search),
        label: AppLocalizations.of(context)!.appSearch,
      ),
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
    return DefaultTabController(
      initialIndex: _currentIndex,
      length: screens.length,
      child: Scaffold(
        body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          children: screens,
        ),
        bottomNavigationBar: !_isDrawerOpen
            ? BottomTabBar(
                onTabChange: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                tabs: _navigatorItems
                    .map(
                      (e) => Tab(
                        iconMargin: const EdgeInsets.only(bottom: 2),
                        icon: e.icon == _navigatorItems[_currentIndex].icon
                            ? e.activeIcon
                            : e.icon,
                        child: Text(
                          e.label!,
                          style: const TextStyle(
                            fontSize: 8,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              )
            : null,
      ),
    );
  }
}
