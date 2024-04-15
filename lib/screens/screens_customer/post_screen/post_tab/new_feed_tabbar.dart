import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pagepals/helpers/color_helper.dart';
import 'package:pagepals/models/post_model.dart';
import 'package:pagepals/screens/screens_customer/post_screen/post_item.dart';
import 'package:pagepals/services/post_service.dart';
import 'package:unicons/unicons.dart';

class NewFeedTabbar extends StatefulWidget {
  const NewFeedTabbar({super.key});

  @override
  State<NewFeedTabbar> createState() => _NewFeedTabbarState();
}

class _NewFeedTabbarState extends State<NewFeedTabbar> {
  PostModel? postModel;

  final ScrollController _scrollController = ScrollController();
  List<PostItemModel> list = [];
  int currentPage = 0;
  bool isLoadingNextPage = false;
  bool hasMorePages = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    getAllPosts();
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
      getNextPosts();
    }
  }

  Future<void> getAllPosts() async {
    var data = await PostService.getAllPosts(currentPage, 10);
    setState(() {
      postModel = data;
      list.addAll(data.list!);
      currentPage++;
      if (data.list!.isEmpty) {
        hasMorePages = false;
      }
    });
  }

  Future<void> getNextPosts() async {
    if (!isLoadingNextPage && hasMorePages) {
      setState(() {
        isLoadingNextPage = true;
      });
      try {
        var data = await PostService.getAllPosts(currentPage, 10);
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
          postModel = null;
          list.clear();
          currentPage = 0;
          hasMorePages = true;
          isLoadingNextPage = false;
        });
        getAllPosts();
      },
      indicatorBuilder: (BuildContext context, IndicatorController controller) {
        return const Icon(
          UniconsLine.book_open,
          color: Colors.blueAccent,
          size: 30,
          semanticLabel: 'Pull to refresh',
        );
      },
      child: postModel == null
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
          : postModel?.list?.isEmpty == true
              ? Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: Text(
                      'No Posts Found',
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              : ListView.builder(
                  itemCount: postModel!.list!.length,
                  itemBuilder: (context, index) {
                    return PostItem(
                      username: postModel!.list![index].reader?.nickname ??
                          'John Doe',
                      timeAgo: postModel!.list![index].createdAt ?? '',
                      postText: postModel!.list![index].content ?? '',
                      imageUrls: postModel!.list![index].postImages ?? [],
                      avatarUrl: postModel!.list![index].reader?.avatarUrl ??
                          'https://via.placeholder.com/150',
                    );
                  },
                ),
    );
  }
}
