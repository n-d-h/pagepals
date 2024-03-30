import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final BottomNavigationBar bottomBar;

  const BottomNavBar({super.key, required this.bottomBar});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: Container(
          margin: const EdgeInsets.fromLTRB(12, 0, 12, 12),
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
            child: bottomBar,
          ),
        ),
      ),
    );
  }
}
