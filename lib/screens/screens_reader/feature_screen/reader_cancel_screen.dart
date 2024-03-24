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
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
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
