import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ReaderRequestScreen extends StatefulWidget {
  const ReaderRequestScreen({super.key});

  @override
  State<ReaderRequestScreen> createState() => _ReaderRequestScreenState();
}

class _ReaderRequestScreenState extends State<ReaderRequestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        automaticallyImplyLeading: false,
        title: Text(AppLocalizations.of(context)!.appRequestToBeReader),
      ),
      body: const Center(
        child: Text('Reader Request Screen'),
      ),
    );
  }
}
