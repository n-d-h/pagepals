import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pagepals/helpers/color_helper.dart';
import 'package:pagepals/helpers/utils.dart';
import 'package:pagepals/models/authen_models/account_model.dart';
import 'package:pagepals/models/withdraw_model.dart';
import 'package:pagepals/services/authen_service.dart';
import 'package:pagepals/services/withdraw_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FinanceWithdrawScreen extends StatefulWidget {
  const FinanceWithdrawScreen({super.key, this.accountModel});

  final AccountModel? accountModel;

  @override
  State<FinanceWithdrawScreen> createState() => _FinanceWithdrawScreenState();
}

class _FinanceWithdrawScreenState extends State<FinanceWithdrawScreen> {
  WithdrawModel? withdrawModel;
  AccountModel? accountModelInside;
  int currentPage = 0;
  bool isLoadingNextPage = false;
  bool hasMorePages = true;
  List<WithdrawItem> list = [];
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    accountModelInside = widget.accountModel;
    _fetchWithdraw();
  }

  @override
  void dispose() {
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

  Future<void> _fetchNextPage() async {
    if (!isLoadingNextPage && hasMorePages) {
      setState(() {
        isLoadingNextPage = true;
      });
      try {
        var result = await WithDrawService.getWithdrawByReaderId(
          currentPage,
          10,
          'desc',
          widget.accountModel!.reader!.id!,
        );
        if (result.list!.isEmpty) {
          setState(() {
            hasMorePages = false;
          });
        } else {
          setState(() {
            currentPage++;
            list.addAll(result.list!);
          });
        }
      } catch (e) {
        print(e);
      } finally {
        setState(() {
          isLoadingNextPage = false;
        });
      }
    }
  }

  Future<void> _fetchWithdraw() async {
    try {
      var result = await WithDrawService.getWithdrawByReaderId(
        currentPage,
        10,
        'desc',
        widget.accountModel!.reader!.id!,
      );

      setState(() {
        withdrawModel = result;
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

  Future<void> _fetchAccount() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('accessToken') ?? '';
      String account = prefs.getString('account') ?? '';
      var accountModel = AccountModel.fromJson(jsonDecode(account));
      String accountId = accountModel.reader!.id!;
      var result = await AuthenService.getAccount(accountId, token);
      if (result != null) {
        setState(() {
          accountModelInside = result;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> fetchData() async {
    setState(() {
      list.clear();
      currentPage = 0;
    });

    // Fetch withdrawal data
    await _fetchWithdraw();

    // Fetch account data
    await _fetchAccount();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _withdrawController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Withdraw'),
        centerTitle: true,
        surfaceTintColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(10),
            width: double.infinity,
            height: 200,
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
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Total Cash:",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      '${accountModelInside?.wallet?.cash ?? 0} Pals',
                      style: const TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Withdraw'),
                          surfaceTintColor: Colors.white,
                          content: Container(
                            height: 150,
                            child: Column(
                              children: [
                                TextField(
                                  controller: _withdrawController,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    hintText: 'Enter amount',
                                  ),
                                ),
                                const SizedBox(height: 40),
                                InkWell(
                                  onTap: () async {
                                    if (_withdrawController.text.isNotEmpty) {
                                      if (int.parse(_withdrawController.text) <=
                                          widget.accountModel!.wallet!.cash!) {
                                        widget
                                            .accountModel!.wallet!.cash = widget
                                                .accountModel!.wallet!.cash! -
                                            int.parse(_withdrawController.text);
                                        bool result = await WithDrawService
                                            .createWithdrawRequest(
                                          widget.accountModel!.reader!.id!,
                                          widget
                                              .accountModel!.reader!.nickname!,
                                          '101010101010',
                                          'Vietcombank',
                                          double.parse(
                                              _withdrawController.text),
                                        );
                                        if (result) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                'Withdraw successfully',
                                              ),
                                            ),
                                          );
                                          await fetchData();
                                          Navigator.pop(context, true);
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                'Withdraw failed',
                                              ),
                                            ),
                                          );
                                        }
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                              'You do not have enough money',
                                            ),
                                          ),
                                        );
                                      }
                                    }
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Center(
                                      child: const Text(
                                        'Withdraw',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      'Withdraw',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              controller: _scrollController,
              slivers: [
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      var item = list[index];
                      String dateTime = item.createdAt ?? '';
                      String date = dateTime.split(' ')[0];
                      String time = dateTime.split(' ')[1].split('.')[0];
                      String dateFormatted = Utils.formatDate(date);

                      var color = Colors.green;
                      var state = item.state;
                      if (state == 'REJECTED') {
                        color = Colors.red;
                      } else if (state == 'PENDING') {
                        color = Colors.orange;
                      }

                      return GestureDetector(
                        onTap: () {
                          if(item.state == 'REJECTED') {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text('Reason'),
                                    surfaceTintColor: Colors.white,
                                    content: Container(
                                      height: 150,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${item.rejectReason ?? ''}',
                                            style: TextStyle(
                                              color: Colors.red,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                            );
                          }
                        },
                        child: Container(
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
                              Expanded(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Amount: ${item.amount} Pals',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              'State:',
                                              style:
                                                  TextStyle(color: Colors.black),
                                            ),
                                            Container(
                                              margin:
                                                  const EdgeInsets.only(left: 10),
                                              padding: const EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                color: color,
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: Text(
                                                item.state ?? '',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                        ),
                      );
                    },
                    childCount: list.isNotEmpty ? list.length : 0,
                  ),
                ),
                withdrawModel == null
                    ? SliverFillRemaining(
                        child: Center(
                          child: LoadingAnimationWidget.staggeredDotsWave(
                            color: ColorHelper.getColor(ColorHelper.green),
                            size: 60,
                          ),
                        ),
                      )
                    : withdrawModel!.list!.length == 0
                        ? SliverFillRemaining(
                            child: Center(
                              child: Text(
                                'No data',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          )
                        : SliverToBoxAdapter(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
