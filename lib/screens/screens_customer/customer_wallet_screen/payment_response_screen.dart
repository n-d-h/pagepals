import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pagepals/helpers/color_helper.dart';
import 'package:pagepals/models/authen_models/account_model.dart';
import 'package:pagepals/models/response_results_code.dart';
import 'package:pagepals/screens/screens_customer/menu_item/menu_item_screen.dart';
import 'package:pagepals/services/authen_service.dart';
import 'package:pagepals/services/momo_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PaymentResponseScreen extends StatefulWidget {
  final Map<String, String>? data;

  const PaymentResponseScreen({super.key, this.data});

  @override
  State<PaymentResponseScreen> createState() => _PaymentResponseScreenState();
}

class _PaymentResponseScreenState extends State<PaymentResponseScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      handleUpdateWallet(widget.data);
      updateAccount();
    });
  }

  void handleUpdateWallet(Map<String, String>? data) async {
    final amount = data?['amount'] ?? '';
    final extraData = data?['extraData'] ?? '';
    final message = data?['message'] ?? '';
    final orderId = data?['orderId'] ?? '';
    final orderInfo = data?['orderInfo'] ?? '';
    final orderType = data?['orderType'] ?? '';
    final partnerCode = data?['partnerCode'] ?? '';
    final payType = data?['payType'] ?? '';
    final requestId = data?['requestId'] ?? '';
    final responseTime = data?['responseTime'] ?? '';
    final resultCode = data?['resultCode'] ?? '';
    final signature = data?['signature'] ?? '';
    final transId = data?['transId'] ?? '';

    await MoMoService.reCheckMoMo(
      amount,
      extraData,
      message,
      orderId,
      orderInfo,
      orderType,
      partnerCode,
      payType,
      requestId,
      responseTime,
      resultCode,
      signature,
      transId,
    );
  }

  void updateAccount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accountString = prefs.getString('account');
    String accessToken = prefs.getString('accessToken')!;
    if (accountString == null) {
      print('No account data found in SharedPreferences');
      return;
    }
    try {
      Map<String, dynamic> accountMap = json.decode(accountString);
      AccountModel account = AccountModel.fromJson(accountMap);
      String userName = account.username!;

      AccountModel updatedAccount = await AuthenService.getAccount(userName, accessToken);
      prefs.setString('account', json.encode(updatedAccount));
    } catch (e) {
      print('Error decoding account data: $e');
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final resultCode = widget.data!['resultCode'] ?? '';

    return Scaffold(
      body: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 70),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            resultCode == "0"
                ? SizedBox(
                    child: Column(
                      children: [
                        Image.asset('assets/booking_success.png'),
                        const SizedBox(height: 10),
                        Text(
                          ResponseResultCode.getMoMoResultCode(resultCode),
                          textAlign: TextAlign.center,
                          style: GoogleFonts.lexend(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            color: ColorHelper.getColor(ColorHelper.green),
                          ),
                        ),
                      ],
                    ),
                  )
                : SizedBox(
                    child: Column(
                      children: [
                        Image.asset('assets/error.png'),
                        const SizedBox(height: 10),
                        Text(
                          ResponseResultCode.getMoMoResultCode(resultCode),
                          textAlign: TextAlign.center,
                          style: GoogleFonts.lexend(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(10),
        child: OutlinedButton(
          onPressed: () {
            Navigator.of(context).push(
              PageTransition(
                child: const MenuItemScreen(),
                type: PageTransitionType.rightToLeft,
                duration: const Duration(milliseconds: 300),
              ),
            );
          },
          // Disable button if not enabled
          style: OutlinedButton.styleFrom(
            splashFactory: NoSplash.splashFactory,
            side: const BorderSide(color: Colors.transparent),
            foregroundColor: ColorHelper.getColor(ColorHelper.white),
            backgroundColor: ColorHelper.getColor(ColorHelper.green),
            padding: const EdgeInsets.symmetric(vertical: 5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Go to Home',
                style: GoogleFonts.lexend(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
