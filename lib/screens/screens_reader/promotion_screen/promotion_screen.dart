import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pagepals/screens/screens_reader/promotion_screen/promotion_create_screen.dart';
import 'package:unicons/unicons.dart';

class PromotionScreen extends StatefulWidget {
  const PromotionScreen({super.key});

  @override
  State<PromotionScreen> createState() => _PromotionScreenState();
}

class _PromotionScreenState extends State<PromotionScreen> {
  final List<Map<String, dynamic>> promotions = [
    {
      'title': '10% Off on Electronics',
      'description':
          'Get 10% off on all electronics items. Limited time offer!',
      'discount_details': 'Use code: ELEC10',
      'percentage': '20% off',
    },
    {
      'title': 'Free Shipping on Orders Over \$50',
      'description': 'Enjoy free shipping on all orders over \$50. Shop now!',
      'discount_details': 'No code required',
      'percentage': '30% off',
    },
    {
      'title': 'Buy 1 Get 1 Free on Clothing',
      'description':
          'Buy 1 get 1 free on all clothing items. Limited time offer!',
      'discount_details': 'No code required',
      'percentage': '50% off',
    },
  ];

  // list colors
  final List<Color> colors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.orange,
    Colors.pink,
    Colors.teal,
    Colors.cyan,
    Colors.indigo,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Promotion'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                promotions.shuffle();
              });
            },
          ),
          IconButton(
            icon: const Icon(UniconsLine.plus_circle),
            onPressed: () {
              Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.bottomToTop,
                  child: const PromotionCreateScreen(),
                ),
              ).then((value) {
                var data = json.decode(value);
                setState(() {
                  promotions.add(data);
                });
              });
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: promotions.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: (index == 0)
                ? const EdgeInsets.only(left: 10, right: 10, top: 10)
                : const EdgeInsets.only(left: 10, right: 10),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Slidable(
              key: Key(promotions[index]['title']),
              endActionPane: ActionPane(
                motion: const ScrollMotion(),
                children: [
                  SlidableAction(
                    onPressed: (context) {
                      _showPromotionDetails(context, promotions[index]);
                    },
                    icon: Icons.edit,
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.orange,
                  ),
                  SlidableAction(
                    onPressed: (context) {
                      // show confirmation dialog
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Delete Promotion'),
                            content: const Text(
                                'Are you sure you want to delete this promotion?'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  setState(() {
                                    promotions.removeAt(index);
                                  });
                                },
                                child: const Text('Delete'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    icon: Icons.delete,
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.red,
                  ),
                ],
              ),
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: colors[index % colors.length],
                    ),
                    height: 150,
                    margin: const EdgeInsets.only(right: 10),
                    child: Center(
                      child: ListTile(
                        title: Text(
                          promotions[index]['title'],
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        subtitle: Text(
                          promotions[index]['description'],
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        onTap: () {
                          _showPromotionDetails(context, promotions[index]);
                        },
                      ),
                    ),
                  ),
                  Positioned(
                    right: 20,
                    top: 10,
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        promotions[index]['percentage'],
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _showPromotionDetails(
    BuildContext context,
    Map<String, dynamic> promotion,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(promotion['title']),
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          elevation: 0,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(promotion['description']),
              const SizedBox(height: 10),
              const Text('Discount Details:',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Text(promotion['discount_details']),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
