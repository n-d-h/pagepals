import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pagepals/helpers/utils.dart';
import 'package:pagepals/models/authen_models/account_model.dart';

class CustomerTransactionScreen extends StatefulWidget {
  const CustomerTransactionScreen({super.key, this.account});

  final AccountModel? account;

  @override
  State<CustomerTransactionScreen> createState() =>
      _CustomerTransactionScreenState();
}

class _CustomerTransactionScreenState extends State<CustomerTransactionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transaction History'),
        centerTitle: true,
        surfaceTintColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView.builder(
        itemCount: widget.account!.wallet?.transactions!.length,
        itemBuilder: (context, index) {
          var transaction = widget.account!.wallet!.transactions![index];

          if(transaction?.transactionType == 'WITHDRAW_MONEY' ||
              transaction?.transactionType == 'BOOKING_DONE_RECEIVE') {
            return Container();
          }

          String dateTime = transaction?.createAt?.toString() ?? '';
          String date = dateTime.split(' ')[0];
          String time = dateTime.split(' ')[1].split('.')[0];
          String dateFormatted = Utils.formatDate(date);

          String currency = '';
          if(transaction?.currency == 'DOLLAR') {
            currency = '\$';
          } else {
            currency = 'pals';
          }
          Color color = Colors.red;
          var prefix = '';
          var description = '';
          Icon icon = const Icon(Icons.arrow_upward, color: Colors.red);
          switch (transaction?.transactionType) {
            case 'DEPOSIT_TOKEN':
              description = 'Deposit token';
              color = Colors.green;
              prefix = '+';
              icon = const Icon(Icons.arrow_downward, color: Colors.green);
              break;
            case 'BOOKING_PAYMENT':
              description = 'Booking payment';
              color = Colors.red;
              prefix = '-';
              icon = const Icon(Icons.arrow_upward, color: Colors.red);
              break;
            case 'BOOKING_REFUND':
              description = 'Booking refund';
              color = Colors.green;
              prefix = '+';
              icon = const Icon(Icons.arrow_downward, color: Colors.green);
              break;
            default:
              description = '';
          }
          return Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(10),
            height: 100,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                icon,
                const SizedBox(width: 50),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                '$prefix${transaction?.amount?.toStringAsFixed(0) ?? ''} $currency',
                                style: TextStyle(color: color),
                              ),
                            ],
                          ),
                          Text(description),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Date: $dateFormatted'),
                          Text('Time: $time'),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
