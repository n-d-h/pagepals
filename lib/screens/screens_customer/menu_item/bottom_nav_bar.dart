import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final BottomNavigationBar bottomBar;

  const BottomNavBar({super.key, required this.bottomBar});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: Container(
        margin: const EdgeInsets.fromLTRB(8, 0, 8, 0),
        decoration: const BoxDecoration(
          // color: Colors.black45.withOpacity(0.9),
          // borderRadius: BorderRadius.all(Radius.circular(20)),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              spreadRadius: 2,
              blurRadius: 3,
            ),
          ],
        ),
        child: ClipRRect(
          // borderRadius: const BorderRadius.all(Radius.circular(20)),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: bottomBar,
        ),
      ),
    );
  }
}
