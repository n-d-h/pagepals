import 'package:flutter/material.dart';
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
          var color = transaction?.transactionType == 'DEPOSIT_TOKEN'
              ? Colors.green
              : Colors.red;
          var minus =
              transaction?.transactionType == 'DEPOSIT_TOKEN' ? '+' : '-';
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.account_balance_wallet),
                        transaction?.transactionType == 'DEPOSIT_TOKEN'
                            ? const Icon(Icons.arrow_downward, color: Colors.green)
                            : const Icon(Icons.arrow_upward, color: Colors.red),
                        Text(
                          '$minus${transaction?.amount?.toStringAsFixed(0) ?? ''}',
                          style: TextStyle(color: color),
                        ),
                      ],
                    ),
                    Text(transaction?.description ?? 'No description'),
                  ],
                ),
                Text(transaction?.createAt?.toString() ?? ''),
              ],
            ),
          );
        },
      ),
    );
  }
}
