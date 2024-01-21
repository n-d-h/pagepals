import 'package:flutter/material.dart';
import 'package:pagepals/screens/dash_board/dash_board_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future main() async {
  runApp(const MyApp());
  await dotenv.load(fileName: ".env");
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Page Pals',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const DashBoardScreen()
    );
  }
}
