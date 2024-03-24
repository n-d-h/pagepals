import 'package:flutter/material.dart';

class PolicyScreen extends StatefulWidget {
  const PolicyScreen({super.key});

  @override
  State<PolicyScreen> createState() => _PolicyScreenState();
}

class _PolicyScreenState extends State<PolicyScreen> {
  // Sample policy texts
  static const String _termsOfServiceText = '''
    Terms of Service
    
    Lorem ipsum dolor sit amet, 
    consectetur adipiscing elit...
    ''';

  static const String _privacyPolicyText = '''
    Privacy Policy
    
    Lorem ipsum dolor sit amet, 
    consectetur adipiscing elit...
    ''';

  static const String _cookiePolicyText = '''
    Cookie Policy
    
    Lorem ipsum dolor sit amet, 
    consectetur adipiscing elit...
    ''';

  static const String _refundPolicyText = '''
    Refund Policy
    
    Lorem ipsum dolor sit amet, 
    consectetur adipiscing elit...
    ''';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          title: const Text('Policies'),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: ListView(
          children: [
            const SizedBox(height: 10),
            _buildPolicyItem(context, 'Terms of Service', _termsOfServiceText),
            _buildPolicyItem(context, 'Privacy Policy', _privacyPolicyText),
            _buildPolicyItem(context, 'Cookie Policy', _cookiePolicyText),
            _buildPolicyItem(context, 'Refund Policy', _refundPolicyText),
          ],
        ),
      ),
    );
  }

  Widget _buildPolicyItem(
    BuildContext context,
    String title,
    String policyText,
  ) {
    return Container(
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        title: Text(title),
        onTap: () {
          _showPolicyDialog(context, title, policyText);
        },
      ),
    );
  }

  void _showPolicyDialog(
    BuildContext context,
    String title,
    String policyText,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          content: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    policyText,
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
          ),
          actions: [
            InkWell(
              onTap: () {
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
