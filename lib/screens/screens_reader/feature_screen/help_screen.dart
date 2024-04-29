import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({super.key});

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Help Center'),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            const Text(
              'Frequently Asked Questions',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            ListTile(
              title: const Text('How do I reset my password?'),
              subtitle: const Text('Tap to see the answer'),
              onTap: () {
                // Implement logic to expand answer
              },
            ),
            ListTile(
              title: const Text('How do I contact support?'),
              subtitle: const Text('Tap to see the answer'),
              onTap: () {
                // Implement logic to expand answer
              },
            ),
            const Divider(),
            TextField(
              decoration: InputDecoration(
                hintText: 'Search help topics',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(
                    color: Colors.grey, // Change the color as needed
                    width: 1.0, // Change the width as needed
                  ),
                ),
              ),
              onChanged: (value) {
                // Implement search functionality
              },
              onSubmitted: (value) {
                // Implement search functionality
              },
            ),
            const Divider(),
            const Text(
              'Contact Information',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            ListTile(
              leading: const Icon(Icons.email),
              title: const Text('pagepals@support.com'),
              onTap: () {
                _sendEmail('pagepals@support.com');
              },
            ),
            ListTile(
              leading: const Icon(Icons.phone),
              title: const Text('+1 123-456-7890'),
              onTap: () {
                _makePhoneCall('+11234567890');
              },
            ),
          ],
        ),
      ),
    );
  }

  void _makePhoneCall(String phoneNumber) async {
    String url = 'tel:$phoneNumber';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  void _sendEmail(String email) async {
    final Uri params = Uri(
      scheme: 'mailto',
      path: email,
      query: 'subject=Feedback', // Optional subject parameter
    );
    String url = params.toString();
    Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      Future.delayed(
        Duration.zero,
        () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Email App Not Found'),
                content: const Text('No email app found.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
        },
      );
    }
  }
}
