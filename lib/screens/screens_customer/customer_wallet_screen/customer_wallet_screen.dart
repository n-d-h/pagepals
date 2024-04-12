import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pagepals/helpers/color_helper.dart';
import 'package:pagepals/models/authen_models/account_model.dart';
import 'package:pagepals/screens/screens_customer/customer_wallet_screen/customer_transaction_screen.dart';
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
                        color: Colors.grey.shade600,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'Balance',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.account?.wallet?.tokenAmount.toString() ?? '0',
                        style: const TextStyle(
                          fontSize: 45,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        ' pals',
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.yellow.shade700,
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
                  InkWell(
                    onTap: () {
                      // showBottomSheet();
                      showRechargeDialog(context);
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
                      width: 160,
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
                  InkWell(
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
                      width: 160,
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showRechargeDialog(BuildContext context) {
    TextEditingController _controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recharge',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: ColorHelper.getColor(ColorHelper.green),
                ),
              ),
              IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                keyboardType: TextInputType.number,
                controller: _controller,
                decoration: InputDecoration(
                  hintText: 'Enter amount',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              SizedBox(height: 20),
              InkWell(
                onTap: () async {
                  Future.delayed(const Duration(milliseconds: 500), () {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return Center(
                          child: LoadingAnimationWidget.staggeredDotsWave(
                            color: Colors.greenAccent,
                            size: 60,
                          ),
                        );
                      },
                    );
                  });
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  String? accountString = prefs.getString('account');
                  if (accountString == null) {
                    return;
                  }
                  Map<String, dynamic> accountMap = json.decode(accountString);
                  AccountModel account = AccountModel.fromJson(accountMap);
                  print(account.customer?.id ?? '');
                  var response = await MoMoService.getMoMoResponse(
                      int.parse(_controller.text), account.customer?.id ?? '');
                  Uri url = Uri.parse(response.payUrl!);

                  if (await canLaunchUrl(url)) {
                    await launchUrl(url, mode: LaunchMode.externalApplication);
                  }

                  Future.delayed(const Duration(seconds: 1), () {
                    Navigator.pop(context);
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.monetization_on,
                        color: Colors.white,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Recharge',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

// void showBottomSheet() {
//   TextEditingController _controller = TextEditingController();
//
//   showModalBottomSheet(
//     context: context,
//     backgroundColor: Colors.white,
//     builder: (context) {
//       return Container(
//         decoration: const BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(20),
//             topRight: Radius.circular(20),
//           ),
//         ),
//         child: Column(
//           children: [
//             Align(
//               alignment: Alignment.topRight,
//               child: Container(
//                 padding: const EdgeInsets.all(10),
//                 child: IconButton(
//                   icon: const Icon(Icons.close),
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),
//             Padding(
//               padding: const EdgeInsets.all(15),
//               child: TextField(
//                 controller: _controller,
//                 decoration: const InputDecoration(
//                   hintText: 'Enter amount',
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.all(Radius.circular(20)),
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),
//             InkWell(
//               onTap: () async {
//                 Future.delayed(const Duration(milliseconds: 500), () {
//                   showDialog(
//                     context: context,
//                     barrierDismissible: false,
//                     builder: (BuildContext context) {
//                       return Center(
//                         child: LoadingAnimationWidget.staggeredDotsWave(
//                           color: Colors.greenAccent,
//                           size: 60,
//                         ),
//                       );
//                     },
//                   );
//                 });
//                 SharedPreferences prefs =
//                     await SharedPreferences.getInstance();
//                 String? accountString = prefs.getString('account');
//                 if (accountString == null) {
//                   return;
//                 }
//                 Map<String, dynamic> accountMap = json.decode(accountString);
//                 AccountModel account = AccountModel.fromJson(accountMap);
//                 print(account.customer?.id ?? '');
//                 var response = await MoMoService.getMoMoResponse(
//                     int.parse(_controller.text), account.customer?.id ?? '');
//                 Uri url = Uri.parse(response.payUrl!);
//
//                 if (await canLaunchUrl(url)) {
//                   await launchUrl(url, mode: LaunchMode.externalApplication);
//                 }
//
//                 Future.delayed(const Duration(seconds: 1), () {
//                   Navigator.pop(context);
//                 });
//               },
//               child: Container(
//                 padding: const EdgeInsets.all(15),
//                 margin: const EdgeInsets.all(15),
//                 decoration: BoxDecoration(
//                   color: Colors.orange,
//                   borderRadius: BorderRadius.circular(20),
//                   boxShadow: const [
//                     BoxShadow(
//                       color: Colors.grey,
//                       blurRadius: 10,
//                       offset: Offset(0, 5),
//                     ),
//                   ],
//                 ),
//                 child: const Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Icon(
//                       Icons.monetization_on,
//                       color: Colors.white,
//                     ),
//                     SizedBox(width: 10),
//                     Text(
//                       'ReCharge',
//                       style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       );
//     },
//   );
// }
}
