import 'package:flutter/material.dart';
import 'package:pagepals/helpers/color_helper.dart';

class BottomTabBar extends StatefulWidget {
  final List<Tab> tabs;
  final Function(int) onTabChange;

  const BottomTabBar(
      {super.key, required this.tabs, required this.onTabChange});

  @override
  State<BottomTabBar> createState() => _BottomTabBarState();
}

class _BottomTabBarState extends State<BottomTabBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            spreadRadius: 2,
            blurRadius: 3,
          ),
        ],
      ),
      child: TabBar(
        onTap: (index) {
          widget.onTabChange(index);
        },
        dividerColor: Colors.transparent,
        labelPadding: EdgeInsets.zero,
        padding: const EdgeInsets.only(bottom: 7),
        tabs: widget.tabs,
        labelColor: ColorHelper.getColor(ColorHelper.green),
        unselectedLabelColor: Colors.grey,
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorPadding: const EdgeInsets.symmetric(horizontal: 7),
        indicator: BoxDecoration(
          gradient: LinearGradient(
            end: const FractionalOffset(0.0, 1.0),
            begin: const FractionalOffset(0.0, 0.0),
            colors: [
              Colors.grey.withOpacity(0.1),
              Colors.white.withAlpha(0),
              // Adjust opacity and color stops as needed
            ],
            tileMode: TileMode.clamp,
            stops: const [0.0, 1.0],
          ),
          border: const Border(
            top: BorderSide(
              color: Colors.greenAccent,
              width: 2,
            ),
          ),
        ),
      ),
    );
  }
}
