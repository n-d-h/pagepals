import 'package:flutter/material.dart';

class ReaderRequestStep1 extends StatefulWidget {
  const ReaderRequestStep1({super.key});

  @override
  State<ReaderRequestStep1> createState() => _ReaderRequestStep1State();
}

class _ReaderRequestStep1State extends State<ReaderRequestStep1> {
  final _formKey = GlobalKey<FormState>();

  String? _name;
  int? _age;
  String? _address;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'Name'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your name';
                }
                return null;
              },
              onSaved: (value) {
                _name = value;
              },
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Age'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your age';
                }
                return null;
              },
              onSaved: (value) {
                _age = int.tryParse(value!);
              },
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Address'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your address';
                }
                return null;
              },
              onSaved: (value) {
                _address = value;
              },
            ),
          ],
        ),
      ),
    );
  }
}
