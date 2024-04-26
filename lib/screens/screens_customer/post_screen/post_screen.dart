import 'dart:convert';

import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pagepals/helpers/color_helper.dart';
import 'package:pagepals/models/authen_models/account_model.dart';
import 'package:pagepals/models/seminar_model.dart';
import 'package:pagepals/screens/screens_customer/post_screen/seminar_widgets/seminar_post_detail.dart';
import 'package:pagepals/screens/screens_customer/post_screen/seminar_widgets/seminar_post_item.dart';
import 'package:pagepals/services/seminar_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unicons/unicons.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final ScrollController _scrollController = ScrollController();
  SeminarModel? seminarModel;
  List<SeminarItem> list = [];
  int currentPage = 0;
  bool isLoadingNextPage = false;
  bool hasMorePages = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    _fetchAllSeminar();
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
      _fetchNextSeminar();
    }
  }

  Future<void> _fetchAllSeminar() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String accountString = prefs.getString('account') ?? '';
    AccountModel accountModel = AccountModel.fromJson(jsonDecode(accountString));
    String customerId = accountModel.customer?.id ?? '';

    var data = await SeminarService.getAllSeminarsNotJoinedByCustomer(
        currentPage, 10, customerId);
    setState(() {
      seminarModel = data;
      list.addAll(data.list!);
      currentPage++;
      if (data.list!.isEmpty) {
        hasMorePages = false;
      }
    });
  }

  Future<void> _fetchNextSeminar() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String accountString = prefs.getString('account') ?? '';
    AccountModel accountModel = AccountModel.fromJson(jsonDecode(accountString));
    String customerId = accountModel.customer?.id ?? '';

    if (!isLoadingNextPage && hasMorePages) {
      setState(() {
        isLoadingNextPage = true;
      });
      try {
        var data = await SeminarService.getAllSeminarsNotJoinedByCustomer(
            currentPage, 10, customerId);
        if (data.list!.isEmpty) {
          setState(() {
            hasMorePages = false;
            isLoadingNextPage = false;
          });
        } else {
          setState(() {
            list.addAll(data.list!);
            currentPage++;
            isLoadingNextPage = false;
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

  @override
  Widget build(BuildContext context) {
    return CustomMaterialIndicator(
      backgroundColor: Colors.grey[100],
      displacement: 20,
      onRefresh: () async {
        Future.delayed(const Duration(seconds: 7));
        setState(() {
          seminarModel = null;
          list.clear();
          currentPage = 0;
          hasMorePages = true;
          isLoadingNextPage = false;
        });
        _fetchAllSeminar();
      },
      indicatorBuilder: (context, controller) {
        return const Icon(
          UniconsLine.book_open,
          color: Colors.blueAccent,
          size: 30,
          semanticLabel: 'Pull to refresh',
        );
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'PagePals and Friends',
            style: TextStyle(
              color: Colors.blueAccent,
              fontSize: 24,
              fontWeight: FontWeight.bold,
              letterSpacing: -1.2,
            ),
          ),
          surfaceTintColor: Colors.white,
          backgroundColor: Colors.white,
          elevation: 0,
          automaticallyImplyLeading: false,
        ),
        body: seminarModel == null
            ? Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: LoadingAnimationWidget.staggeredDotsWave(
                    color: ColorHelper.getColor(ColorHelper.green),
                    size: 60,
                  ),
                ),
              )
            : seminarModel!.list!.isEmpty
                ? Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                      child: Text(
                        'No Posts Found',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  )
                : Container(
                    margin: const EdgeInsets.only(bottom: 50),
                    child: ListView.builder(
                      controller: _scrollController,
                      itemCount: list.length,
                      itemBuilder: (context, index) {
                        var seminarItem = list[index];
                        String date = seminarItem.startTime!.split(' ')[0];
                        String time = seminarItem.startTime!.split(' ')[1];
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              PageTransition(
                                child: SeminarPostDetailScreen(
                                  seminarId: seminarItem.id ?? '',
                                  hostName: seminarItem.reader?.nickname ?? '',
                                  seminarTitle: seminarItem.title ?? '',
                                  date: date,
                                  time: time,
                                  description: seminarItem.description ?? '',
                                  hostAvatarUrl:
                                      seminarItem.reader?.avatarUrl ??
                                          'https://via.placeholder.com/150',
                                  bannerImageUrl: seminarItem.imageUrl ??
                                      'https://via.placeholder.com/150',
                                  activeSlot: seminarItem.activeSlot ?? 0,
                                  limitCustomer: seminarItem.limitCustomer ?? 0,
                                  price: seminarItem.price ?? 0,
                                ),
                                type: PageTransitionType.rightToLeft,
                              ),
                            );
                          },
                          child: SeminarPostItem(
                            seminarId: seminarItem.id ?? '',
                            hostName: seminarItem.reader?.nickname ?? '',
                            seminarTitle: seminarItem.title ?? '',
                            date: date,
                            time: time,
                            description: seminarItem.description ?? '',
                            hostAvatarUrl: seminarItem.reader?.avatarUrl ??
                                'https://via.placeholder.com/150',
                            bannerImageUrl: seminarItem.imageUrl ??
                                'https://via.placeholder.com/150',
                            activeSlot: seminarItem.activeSlot ?? 0,
                            limitCustomer: seminarItem.limitCustomer ?? 0,
                            price: seminarItem.price ?? 0,
                            onSeminarJoinedDone: (bool result) {
                              if(result) {
                                setState(() {
                                  seminarModel = null;
                                  list.clear();
                                  currentPage = 0;
                                  hasMorePages = true;
                                  isLoadingNextPage = false;
                                });
                                _fetchAllSeminar();
                              }
                            },
                          ),
                        );
                      },
                    ),
                  ),
      ),
    );
  }
}