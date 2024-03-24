import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';

class PromotionCreateScreen extends StatefulWidget {
  const PromotionCreateScreen({super.key});

  @override
  State<PromotionCreateScreen> createState() => _PromotionCreateScreenState();
}

class _PromotionCreateScreenState extends State<PromotionCreateScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Promotion'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(UniconsLine.multiply),
          onPressed: () {
            Navigator.pop(
              context,
              json.encode(
                {
                  'title': '10% Off on Electronics',
                  'description':
                      'Get 10% off on all electronics items. Limited time offer!',
                  'discount_details': 'Use code: ELEC10',
                  'percentage': '30% off',
                },
              ),
            );
          },
        ),
      ),
      body: const Center(
        child: Text('Create Promotion Screen'),
      ),
    );
  }
}
