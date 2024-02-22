import 'package:flutter/material.dart';

class ReaderTabScreen extends StatefulWidget {
  const ReaderTabScreen({super.key});

  @override
  State<ReaderTabScreen> createState() => _ReaderTabScreenState();
}

class _ReaderTabScreenState extends State<ReaderTabScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Reader tab"),
      ),
    );
  }
}
