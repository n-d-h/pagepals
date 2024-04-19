import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pagepals/helpers/color_helper.dart';
import 'package:pagepals/models/seminar_model.dart';
import 'package:pagepals/screens/screens_customer/post_screen/seminar_widgets/seminar_post_item.dart';
import 'package:pagepals/services/seminar_service.dart';
import 'package:unicons/unicons.dart';

class SeminarTabbar extends StatefulWidget {
  const SeminarTabbar({super.key});

  @override
  State<SeminarTabbar> createState() => _SeminarTabbarState();
}

class _SeminarTabbarState extends State<SeminarTabbar> {
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
        setState(() {
          seminarModel = data;
          list.addAll(data.list!);
          currentPage++;
          if (data.list!.isEmpty) {
            hasMorePages = false;
          }
        });
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
      indicatorBuilder: (BuildContext context, IndicatorController controller) {
        return const Icon(
          UniconsLine.book_open,
          color: Colors.blueAccent,
          size: 30,
          semanticLabel: 'Pull to refresh',
        );
      },
      child: seminarModel == null
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
              : ListView.builder(
                  controller: _scrollController,
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    var seminarItem = list[index];
                    String date = seminarItem.startTime!.split(' ')[0];
                    String time = seminarItem.startTime!.split(' ')[1];
                    return SeminarPostItem(
                      hostName: seminarItem.reader?.nickname ?? '',
                      seminarTitle: seminarItem.title ?? '',
                      date: date,
                      time: time,
                      description: seminarItem.description ?? '',
                      hostAvatarUrl: seminarItem.reader?.avatarUrl ??
                          'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png',
                      bannerImageUrl: seminarItem.imageUrl ??
                          'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png',
                    );
                  },
                ),
    );
  }
}
