import 'dart:async';

import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pagepals/helpers/color_helper.dart';
import 'package:pagepals/screens/screens_customer/profile_screen/overview_screen.dart';
import 'package:pagepals/screens/screens_customer/reader_screen/reader_widget.dart';
import 'package:pagepals/services/reader_service.dart';

import 'package:pagepals/models/reader_models/search_reader_model.dart';

class ReaderTabScreen extends StatefulWidget {
  final String? search;

  const ReaderTabScreen({super.key, this.search});

  @override
  State<ReaderTabScreen> createState() => _ReaderTabScreenState();
}

class _ReaderTabScreenState extends State<ReaderTabScreen> {
  int currentPage = 0;
  List<Reader> readers = [];
  bool isLoadingNextPage = false;
  bool hasMorePages = true;
  Timer? _debounce;
  String search = '';

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController.addListener(_scrollListener);
    _fetchCustomerBooks();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    _debounce?.cancel();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _fetchNextPage();
    }
  }

  Future<void> _fetchCustomerBooks() async {
    try {
      SearchReaderModel result = await ReaderService.getListReaders(
          "", "${widget.search ?? ''}", "", "", "", null, currentPage, 10);
      setState(() {
        readers.addAll(result.list!);
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
        SearchReaderModel result = await ReaderService.getListReaders(
            "", "${widget.search ?? ''}", "", "", "", null, currentPage, 10);
        if (result.list!.isEmpty) {
          setState(() {
            hasMorePages = false;
            isLoadingNextPage = false;
          });
        } else {
          setState(() {
            readers.addAll(result.list!);
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
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      if (search != widget.search) {
        setState(() {
          currentPage = 0;
          readers.clear();
          hasMorePages = true;
          search = widget.search ?? '';
        });
        _fetchCustomerBooks();
      }
    });
    return readers.isEmpty
        ? Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: LoadingAnimationWidget.staggeredDotsWave(
                color: ColorHelper.getColor(ColorHelper.green),
                size: 60,
              ),
            ),
          )
        : readers.first.id == null
            ? Scaffold(
                backgroundColor: Colors.white,
                body: Center(
                  child: Text("No results found"),
                ),
              )
            : Scaffold(
                backgroundColor: Colors.white,
                body: ListView.builder(
                  controller: _scrollController,
                  itemCount: readers.length + (isLoadingNextPage ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == readers.length) {
                      return Center(
                        child: LoadingAnimationWidget.prograssiveDots(
                          color: ColorHelper.getColor(ColorHelper.green),
                          size: 50,
                        ),
                      );
                    } else {
                      var reader = readers[index];
                      return ReaderWidget(
                        onTap: () {
                          Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.rightToLeft,
                              child: ProfileOverviewScreen(
                                readerId: reader.id!,
                              ),
                            ),
                          );
                        },
                        reader: reader,
                      );
                    }
                  },
                ),
              );
  }
}
