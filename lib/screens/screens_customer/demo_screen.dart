import 'package:flutter/material.dart';

class DemoScreen extends StatelessWidget {
  DemoScreen({
    super.key,
    required this.partnerCode,
    required this.orderId,
    required this.requestId,
    required this.amount,
    required this.orderInfo,
    required this.orderType,
    required this.transId,
    required this.resultCode,
    required this.message,
    required this.responseTime,
    required this.extraData,
    required this.signature,
    required this.payType,
  });

  String partnerCode;
  String orderId;
  String requestId;
  String amount;
  String orderInfo;
  String orderType;
  String transId;
  String resultCode;
  String payType;
  String message;
  String responseTime;
  String extraData;
  String signature;

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
