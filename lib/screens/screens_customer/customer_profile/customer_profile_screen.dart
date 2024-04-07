import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pagepals/models/authen_models/account_model.dart';
import 'package:pagepals/screens/screens_customer/customer_profile/customer_edit_profile_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomerProfileScreen extends StatefulWidget {
  const CustomerProfileScreen({super.key});

  @override
  State<CustomerProfileScreen> createState() => _CustomerProfileScreenState();
}

class _CustomerProfileScreenState extends State<CustomerProfileScreen> {
  AccountModel? account;

  @override
  void initState() {
    super.initState();
    getAccount();
  }

  Future<void> getAccount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accountString = prefs.getString('account');
    if (accountString != null) {
      AccountModel accountModel = AccountModel.fromJson(json.decoder.convert(accountString));
      setState(() {
        account = accountModel;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
        surfaceTintColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          InkWell(
            child: Container(
              padding: const EdgeInsets.all(10),
              child: const Icon(Icons.edit),
            ),
            onTap: () {
              Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.rightToLeft,
                  child: CustomerEditProfileScreen(
                    account: account,
                  ),
                ),
              ).then((value) {
                if (value != null) {
                  setState(() {
                    account = value;
                  });
                }
              });
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        controller: ScrollController(),
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(
                  account?.customer?.imageUrl ??
                      'https://via.placeholder.com/150',
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Personal Information',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  customerDataField('Username', account?.username),
                  customerDataField('Email', account?.email),
                  customerDataField('Full Name', account?.customer?.fullName),
                  customerDataField('Phone Number', account?.phoneNumber),
                  customerDataField('Date of Birth', account?.customer?.dob),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget customerDataField(String title, String? value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            value ?? '',
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black,
              fontWeight: FontWeight.w200,
            ),
          ),
        ],
      ),
    );
  }
}
