import 'package:flutter/material.dart';

class ReaderEditProfileScreen extends StatefulWidget {
  const ReaderEditProfileScreen({super.key});

  @override
  State<ReaderEditProfileScreen> createState() =>
      _ReaderEditProfileScreenState();
}

class _ReaderEditProfileScreenState extends State<ReaderEditProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text('Edit Profile'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: const Center(
        child: Text('Edit Profile'),
      ),
    );
  }
}
