import 'package:flutter/material.dart';
import 'package:pagepals/helpers/space_helper.dart';
import 'package:pagepals/screens/order_screen/video_conferencPage.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {

  final TextEditingController _textEditingController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _textEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Orders',
          style: TextStyle(
            fontSize: SpaceHelper.space24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        controller: ScrollController(),
        child: Center(
          child: Column(
            children: [
              TextField(
                controller: _textEditingController,
                style: TextStyle(fontSize: 25),
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: 'Enter your order',
                  hintStyle: TextStyle(fontSize: 25),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => VideoConferencePage(
                        conferenceID: _textEditingController.text,
                      ),
                    ),
                  );
                },
                child: Text('Order'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
