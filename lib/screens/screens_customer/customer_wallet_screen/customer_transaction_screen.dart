import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pagepals/helpers/color_helper.dart';
import 'package:pagepals/helpers/utils.dart';
import 'package:pagepals/models/authen_models/account_model.dart';
import 'package:pagepals/models/customer_transaction_model.dart';
import 'package:pagepals/services/customer_service.dart';

class CustomerTransactionScreen extends StatefulWidget {
  const CustomerTransactionScreen({super.key, this.account});

  final AccountModel? account;

  @override
  State<CustomerTransactionScreen> createState() =>
      _CustomerTransactionScreenState();
}

class _CustomerTransactionScreenState extends State<CustomerTransactionScreen> {
  // CustomerTransactionModel? customerTransactionModel;
  int currentPage = 0;
  bool isLoadingNextPage = false;
  bool hasMorePages = true;
  List<TransactionModel> list = [];

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    _fetchCustomerTransaction();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _fetchNextPage();
    }
  }

  Future<void> _fetchCustomerTransaction() async {
    try {
      var result = await CustomerService.getCustomerTransaction(
        widget.account?.customer?.id ?? '',
        currentPage,
        10,
        DateFormat('yyyy-MM-dd')
            .format(DateTime.now().subtract(const Duration(days: 365))),
        DateFormat('yyyy-MM-dd').format(DateTime.now()),
        '',
      );

      setState(() {
        list.addAll(result.list!);
        currentPage++;
        if (result.list!.isEmpty) {
          hasMorePages = false;
        }
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> _fetchNextPage() async {
    if (!isLoadingNextPage && hasMorePages) {
      setState(() {
        isLoadingNextPage = true;
      });
      try {
        var result = await CustomerService.getCustomerTransaction(
          widget.account?.customer?.id ?? '',
          currentPage,
          10,
          DateFormat('yyyy-MM-dd')
              .format(DateTime.now().subtract(const Duration(days: 365))),
          DateFormat('yyyy-MM-dd').format(DateTime.now()),
          '',
        );
        if (result.list!.isEmpty) {
          setState(() {
            hasMorePages = false;
            isLoadingNextPage = false;
          });
        } else {
          setState(() {
            list.addAll(result.list!);
            currentPage++;
            isLoadingNextPage = false;
          });
        }
      } catch (error) {
        print("Error fetching next page: $error");
        setState(() {
          isLoadingNextPage = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return list.isEmpty
        ? Scaffold(
            body: Center(
              child: LoadingAnimationWidget.staggeredDotsWave(
                color: ColorHelper.getColor(ColorHelper.green),
                size: 60,
              ),
            ),
          )
        : Scaffold(
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
              controller: _scrollController,
              itemCount: list.length + (isLoadingNextPage ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == list.length) {
                  return Center(
                    child: LoadingAnimationWidget.prograssiveDots(
                      color: ColorHelper.getColor(ColorHelper.green),
                      size: 50,
                    ),
                  );
                } else {
                  var transaction = list[index];

                  if (transaction.transactionType == 'WITHDRAW_MONEY' ||
                      transaction.transactionType == 'BOOKING_DONE_RECEIVE') {
                    return Container();
                  }

                  String dateTime = transaction.createAt?.toString() ?? '';
                  String date = dateTime.split(' ')[0];
                  String time = dateTime.split(' ')[1].split('.')[0];
                  String dateFormatted = Utils.formatDate(date);

                  String currency = '';
                  if (transaction.currency == 'DOLLAR') {
                    currency = '\$';
                  } else {
                    currency = 'pals';
                  }
                  Color color = Colors.red;
                  var prefix = '';
                  var description = '';
                  Icon icon = const Icon(Icons.arrow_upward, color: Colors.red);
                  switch (transaction.transactionType) {
                    case 'DEPOSIT_TOKEN':
                      description = 'Deposit token';
                      color = Colors.green;
                      prefix = '+';
                      icon =
                          const Icon(Icons.arrow_downward, color: Colors.green);
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
                      icon =
                          const Icon(Icons.arrow_downward, color: Colors.green);
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
                                        '$prefix${transaction.amount?.toStringAsFixed(0) ?? ''} $currency',
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
                }
              },
            ),
          );
  }
}
