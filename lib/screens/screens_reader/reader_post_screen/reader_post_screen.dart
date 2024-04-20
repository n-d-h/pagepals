import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pagepals/helpers/color_helper.dart';
import 'package:pagepals/models/authen_models/account_model.dart';
import 'package:pagepals/models/post_model.dart';
import 'package:pagepals/screens/screens_reader/reader_post_screen/post_item.dart';
import 'package:pagepals/screens/screens_reader/reader_post_screen/post_status_screen.dart';
import 'package:pagepals/services/post_service.dart';
import 'package:unicons/unicons.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ReaderPostScreen extends StatefulWidget {
  const ReaderPostScreen({super.key, this.accountModel});

  final AccountModel? accountModel;

  @override
  State<ReaderPostScreen> createState() => _ReaderPostScreenState();
}

class _ReaderPostScreenState extends State<ReaderPostScreen> {
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
    String readerId = widget.accountModel?.reader?.id ?? '';
    var data = await PostService.getPostByReaderId(readerId, currentPage, 10);
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
        String readerId = widget.accountModel?.reader?.id ?? '';
        var data =
        await PostService.getPostByReaderId(readerId, currentPage, 10);
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
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'My Post',
            style: const TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              letterSpacing: -1.2,
            ),
          ),
          surfaceTintColor: Colors.white,
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop(context);
            },
            splashRadius: 24,
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
        ),
        body: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 24,
                      backgroundImage: NetworkImage(
                          widget.accountModel?.reader?.avatarUrl ??
                              'https://via.placeholder.com/150'),
                    ),
                    const SizedBox(width: 16),
                    SizedBox(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * 0.7,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(10),
                        onTap: () {
                          Navigator.push(
                            context,
                            PageTransition(
                              child: PostStatusScreen(
                                accountModel: widget.accountModel,
                              ),
                              type: PageTransitionType.fade,
                              duration: const Duration(milliseconds: 300),
                            ),
                          ).then((value) =>
                          {
                            setState(() {
                              postModel = null;
                              list.clear();
                              currentPage = 0;
                              hasMorePages = true;
                              isLoadingNextPage = false;
                            }),
                            getAllPosts(),
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(9),
                          child: Text(
                            AppLocalizations.of(context)!.appWhatAreYouThinking,
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              postModel == null
                  ? Container(
                height: MediaQuery
                    .of(context)
                    .size
                    .height,
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                child: Center(
                  child: LoadingAnimationWidget.staggeredDotsWave(
                    color: ColorHelper.getColor(ColorHelper.green),
                    size: 60,
                  ),
                ),
              )
                  : postModel?.list?.isEmpty == true
                  ? Container(
                height: MediaQuery
                    .of(context)
                    .size
                    .height,
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                child: Center(
                  child: Container(
                    // margin appbar height + 20
                    margin: const EdgeInsets.only(bottom: 80),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/no_booking.png',
                          width: 200,
                          height: 200,
                          fit: BoxFit.fill,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Empty list',
                          style: GoogleFonts.caveatBrush(
                            color: Colors.black,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          'No Post Found.',
                          overflow: TextOverflow.clip,
                          style: GoogleFonts.openSans(
                            color: Colors.black54,
                            fontSize: 18,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
                  : Column(
                children: postModel!.list!.map((e) {
                  return PostItem(
                    username: e.reader?.nickname ?? 'John Doe',
                    timeAgo: e.createdAt ?? '',
                    postText: e.content ?? '',
                    imageUrls: e.postImages ?? [],
                    avatarUrl: e.reader?.avatarUrl ??
                        'https://via.placeholder.com/150',
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
