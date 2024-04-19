import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pagepals/helpers/color_helper.dart';
import 'package:pagepals/models/seminar_model.dart';
import 'package:pagepals/screens/screens_reader/reader_seminars/reader_seminar_create_screen.dart';
import 'package:pagepals/screens/screens_reader/reader_seminars/seminar_widgets/seminar_post_detail.dart';
import 'package:pagepals/screens/screens_reader/reader_seminars/seminar_widgets/seminar_post_item.dart';
import 'package:pagepals/services/seminar_service.dart';
import 'package:unicons/unicons.dart';

class ReaderSeminarScreen extends StatefulWidget {
  const ReaderSeminarScreen({super.key});

  @override
  State<ReaderSeminarScreen> createState() => _ReaderSeminarScreenState();
}

class _ReaderSeminarScreenState extends State<ReaderSeminarScreen> {
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
    var data = await SeminarService.getAllSeminars(currentPage, 10);
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
    if (!isLoadingNextPage && hasMorePages) {
      setState(() {
        isLoadingNextPage = true;
      });
      try {
        var data = await SeminarService.getAllSeminars(currentPage, 10);
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
          title: const Text('Seminar'),
          elevation: 0,
          centerTitle: true,
          surfaceTintColor: Colors.white,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            IconButton(
              icon: const Icon(UniconsLine.plus_circle),
              onPressed: () {
                Navigator.push(
                  context,
                  PageTransition(
                    child: ReaderSeminarCreateScreen(),
                    type: PageTransitionType.rightToLeft,
                  ),
                );
              },
            ),
          ],
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
                          ),
                        );
                      },
                    ),
                  ),
      ),
    );
  }
}
