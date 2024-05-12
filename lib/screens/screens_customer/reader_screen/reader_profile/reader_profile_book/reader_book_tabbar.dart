import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pagepals/helpers/color_helper.dart';
import 'package:pagepals/models/book_models/book_model.dart';
import 'package:pagepals/services/book_service.dart';

class ReaderBookTabbar extends StatefulWidget {
  final String readerId;

  const ReaderBookTabbar({super.key, required this.readerId});

  @override
  State<ReaderBookTabbar> createState() => _ReaderBookTabbarState();
}

class _ReaderBookTabbarState extends State<ReaderBookTabbar> {
  int currentPage = 0;
  List<Books> books = [];
  bool isLoadingNextPage = false;
  bool hasMorePages = true;
  String search = '';
  int totalElements = 0;

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    _fetchReaderBooks();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        books.length < totalElements) {
      _fetchNextPage();
    }
  }

  Future<void> _fetchReaderBooks() async {
    try {
      BookModel result = await BookService.getReaderBooks(
          widget.readerId, '', currentPage, 10);
      setState(() {
        books.addAll(result.list!);
        totalElements = result.paging?.totalOfElements ?? 0;
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
        BookModel result = await BookService.getReaderBooks(
            widget.readerId, '', currentPage, 10);
        if (result.list!.isEmpty) {
          setState(() {
            hasMorePages = false;
            isLoadingNextPage = false;
          });
        } else {
          setState(() {
            books.addAll(result.list!);
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
    return books.isEmpty
        ? Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: LoadingAnimationWidget.staggeredDotsWave(
                color: ColorHelper.getColor(ColorHelper.green),
                size: 60,
              ),
            ),
          )
        : books.first.book == null
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
                  itemCount: books.length + (isLoadingNextPage ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == books.length) {
                      return Center(
                        child: LoadingAnimationWidget.prograssiveDots(
                          color: ColorHelper.getColor(ColorHelper.green),
                          size: 50,
                        ),
                      );
                    } else {
                      var book = books[index];
                      return Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.all(8),
                        margin: const EdgeInsets.only(bottom: 2),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: 100,
                              height: 140,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image: NetworkImage(
                                      book.book?.smallThumbnailUrl ??
                                          "https://via.placeholder.com/150"),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    book.book?.title ?? '',
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 3,
                                    softWrap: false,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
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
    // return SingleChildScrollView(
    //   child: Container(
    //     width: MediaQuery.of(context).size.width * 0.9,
    //     padding: const EdgeInsets.all(SpaceHelper.space16),
    //     child: const Column(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       mainAxisAlignment: MainAxisAlignment.start,
    //       children: [
    //         BookCollectionWidget(),
    //         BookCollectionWidget(),
    //         BookCollectionWidget(),
    //         BookCollectionWidget(),
    //         BookCollectionWidget(),
    //       ],
    //     ),
    //   ),
    // );
  }
}
