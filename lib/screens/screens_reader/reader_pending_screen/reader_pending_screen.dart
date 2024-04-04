import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pagepals/screens/screens_customer/menu_item/menu_item_screen.dart';

class ReaderPendingScreen extends StatefulWidget {
  const ReaderPendingScreen({super.key});

  @override
  State<ReaderPendingScreen> createState() => _ReaderPendingScreenState();
}

class _ReaderPendingScreenState extends State<ReaderPendingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reader Pending Screen'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Waiting for staff to approve your account and Interview',
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.leftToRight,
                    child: const MenuItemScreen(),
                    duration: const Duration(milliseconds: 300),
                  ),
                );
              },
              child: const Text('Back to Main Screen'),
            ),
          ],
        ),
      ),
    );
  }
}
