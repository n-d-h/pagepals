import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pagepals/helpers/color_helper.dart';
import 'package:pagepals/models/authen_models/account_model.dart';
import 'package:pagepals/screens/screens_customer/customer_wallet_screen/customer_transaction_screen.dart';
import 'package:pagepals/screens/screens_customer/customer_wallet_screen/recharge_dialog.dart';
import 'package:pagepals/screens/screens_reader/reader_widgets/transaction_money_widget.dart';
import 'package:pagepals/services/momo_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomerWalletScreen extends StatefulWidget {
  const CustomerWalletScreen({super.key, this.account});

  final AccountModel? account;

  @override
  State<CustomerWalletScreen> createState() => _CustomerWalletScreenState();
}

class _CustomerWalletScreenState extends State<CustomerWalletScreen> {
  @override
  Widget build(BuildContext context) {
    int pals = widget.account?.wallet?.tokenAmount ?? 0;
    // int pals = 100000;
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Wallet'),
        centerTitle: true,
        surfaceTintColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        controller: ScrollController(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 250,
              padding: const EdgeInsets.all(15),
              margin: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.monetization_on,
                        color: Colors.grey.shade500,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'Balance',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        pals >= 100000
                            ? '${NumberFormat.compact(
                                locale: 'en_US',
                                explicitSign: false,
                              ).format(pals)} '
                            : '${NumberFormat.currency(
                                locale: 'vi_VN',
                                symbol: '',
                              ).format(pals)}',
                        style: GoogleFonts.changa(
                          fontSize: 45,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      Text(
                        'pals',
                        style: GoogleFonts.kalam(
                          fontSize: 30,
                          color: ColorHelper.getColor(ColorHelper.green),
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        // showBottomSheet();
                        showRechargeDialog(context, widget.account);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 10,
                              offset: Offset(0, 5),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(15),
                        child: Row(
                          children: [
                            TransactionMoneyWidget.sendButton(),
                            const SizedBox(width: 16),
                            Text(
                              'Recharge',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 25),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.bottomToTop,
                            child: CustomerTransactionScreen(
                              account: widget.account,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 10,
                              offset: Offset(0, 5),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(15),
                        child: Row(
                          children: [
                            TransactionMoneyWidget.transactionButton(),
                            const SizedBox(width: 16),
                            Text(
                              'History',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showRechargeDialog(BuildContext context, AccountModel? account) {
    showDialog(
      context: context,
      builder: (context) {
        return RechargeDialog(account: account);
      },
    );
  }
}
