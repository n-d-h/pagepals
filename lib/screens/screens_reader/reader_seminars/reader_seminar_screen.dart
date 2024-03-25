import 'package:flutter/material.dart';

class ReaderSeminarScreen extends StatefulWidget {
  const ReaderSeminarScreen({super.key});

  @override
  State<ReaderSeminarScreen> createState() => _ReaderSeminarScreenState();
}

class _ReaderSeminarScreenState extends State<ReaderSeminarScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Seminar'),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        child: const Text('Seminar Screen'),
      ),
    );
  }
}
