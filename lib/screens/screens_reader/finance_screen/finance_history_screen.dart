import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pagepals/helpers/color_helper.dart';
import 'package:pagepals/helpers/utils.dart';
import 'package:pagepals/models/authen_models/account_model.dart';
import 'package:pagepals/models/reader_transaction_model.dart';
import 'package:pagepals/services/reader_service.dart';

class FinanceHistoryScreen extends StatefulWidget {
  const FinanceHistoryScreen({super.key, this.accountModel});

  final AccountModel? accountModel;

  @override
  State<FinanceHistoryScreen> createState() => _FinanceHistoryScreenState();
}

class _FinanceHistoryScreenState extends State<FinanceHistoryScreen> {
  ReaderTransactionModel? readerTransactionModel;

  @override
  void initState() {
    super.initState();
    getListReaderTransaction();
  }

  Future<void> getListReaderTransaction() async {
    var data = await ReaderService.getReaderTransaction(
        widget.accountModel!.reader!.id!,
        0,
        10,
        '2023-12-01',
        '2024-04-09',
        '');

    setState(() {
      readerTransactionModel = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return readerTransactionModel == null
        ? Scaffold(
            body: Center(
              child: LoadingAnimationWidget.staggeredDotsWave(
                  color: ColorHelper.getColor(ColorHelper.green), size: 60),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: const Text('History'),
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
              itemCount: readerTransactionModel?.list?.length,
              itemBuilder: (context, index) {
                var transaction = readerTransactionModel?.list?[index];

                if (transaction?.transactionType == 'DEPOSIT_TOKEN' ||
                    transaction?.transactionType == 'BOOKING_PAYMENT' ||
                    transaction?.transactionType == 'BOOKING_REFUND') {
                  return Container();
                }

                String dateTime = transaction?.createAt?.toString() ?? '';
                String date = dateTime.split(' ')[0];
                String time = dateTime.split(' ')[1].split('.')[0];
                String dateFormatted = Utils.formatDate(date);

                String currency = '';
                if (transaction?.currency == 'DOLLAR') {
                  currency = '\$';
                } else {
                  currency = 'pals';
                }

                var color =
                    transaction?.transactionType == 'BOOKING_DONE_RECEIVE'
                        ? Colors.green
                        : Colors.red;
                var minus =
                    transaction?.transactionType == 'BOOKING_DONE_RECEIVE'
                        ? '+'
                        : '-';
                var description = '';
                if (transaction?.transactionType == 'WITHDRAW_MONEY') {
                  description = 'Withdraw money';
                } else if (transaction?.transactionType ==
                    'BOOKING_DONE_RECEIVE') {
                  description = 'Booking done receive';
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
                      transaction?.transactionType == 'BOOKING_DONE_RECEIVE'
                          ? const Icon(Icons.arrow_downward,
                              color: Colors.green)
                          : const Icon(Icons.arrow_upward, color: Colors.red),
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
                                      '$minus${transaction?.amount?.toStringAsFixed(0) ?? ''} $currency',
                                      style: TextStyle(color: color),
                                    ),
                                  ],
                                ),
                                Text(
                                  description,
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                  ),
                                ),
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
