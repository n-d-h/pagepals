import 'package:flutter/material.dart';

class ReaderCancelScreen extends StatefulWidget {
  const ReaderCancelScreen({super.key});

  @override
  State<ReaderCancelScreen> createState() => _ReaderCancelScreenState();
}

class _ReaderCancelScreenState extends State<ReaderCancelScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cancel Screen'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Back'),
        ),
      ),
    );
  }
}
