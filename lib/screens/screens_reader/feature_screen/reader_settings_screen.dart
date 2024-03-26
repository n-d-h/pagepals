import 'package:flutter/material.dart';
import 'package:pagepals/helpers/color_helper.dart';

class ReaderSettingScreen extends StatefulWidget {
  const ReaderSettingScreen({super.key});

  @override
  State<ReaderSettingScreen> createState() => _ReaderSettingScreenState();
}

class _ReaderSettingScreenState extends State<ReaderSettingScreen> {
  bool _isSwitched1 = false;
  bool _isSwitched2 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text('Reader Setting'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.white,
              margin: const EdgeInsets.only(top: 10, bottom: 10),
              child: ListTile(
                title: const Text('Font Size'),
                trailing: Switch(
                  activeColor: ColorHelper.getColor(ColorHelper.greenActive),
                  value: _isSwitched1,
                  onChanged: (value) {
                    setState(() {
                      _isSwitched1 = value;
                    });
                  },
                ),
              ),
            ),
            Container(
              color: Colors.white,
              margin: const EdgeInsets.only(bottom: 10),
              child: ListTile(
                title: const Text('Font Family'),
                trailing: Switch(
                  activeColor: ColorHelper.getColor(ColorHelper.greenActive),
                  value: _isSwitched2,
                  onChanged: (value) {
                    setState(() {
                      _isSwitched2 = value;
                    });
                  },
                ),
              ),
            ),
            Container(
              color: Colors.white,
              margin: const EdgeInsets.only(bottom: 10),
              child: ListTile(
                title: const Text('Theme'),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  print('Theme');
                },
              ),
            ),
            Container(
              color: Colors.white,
              margin: const EdgeInsets.only(bottom: 10),
              child: ListTile(
                title: const Text('Line Height'),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  print('Line Height');
                },
              ),
            ),
            Container(
              color: Colors.white,
              margin: const EdgeInsets.only(bottom: 10),
              child: ListTile(
                title: const Text('Letter Spacing'),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  print('Letter Spacing');
                },
              ),
            ),
            Container(
              color: Colors.white,
              margin: const EdgeInsets.only(bottom: 10),
              child: ListTile(
                title: const Text('Paragraph Spacing'),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  print('Paragraph Spacing');
                },
              ),
            ),
            Container(
              color: Colors.white,
              margin: const EdgeInsets.only(bottom: 10),
              child: ListTile(
                title: const Text('Margin'),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  print('Margin');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
