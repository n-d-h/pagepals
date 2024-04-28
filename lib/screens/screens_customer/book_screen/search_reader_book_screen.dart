import 'dart:async';

import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pagepals/helpers/color_helper.dart';
import 'package:pagepals/models/book_models/book_model.dart';
import 'package:pagepals/screens/screens_customer/book_screen/book_detail_widgets/reader_book_detail.dart';
import 'package:pagepals/services/book_service.dart';
import 'package:unicons/unicons.dart';

class SearchReaderBooks extends StatefulWidget {
  final String readerId;
  final Function(String) onSelected;

  const SearchReaderBooks(
      {super.key, required this.readerId, required this.onSelected});

  @override
  State<SearchReaderBooks> createState() => _SearchReaderBooksState();
}

class _SearchReaderBooksState extends State<SearchReaderBooks> {
  TextEditingController searchController = TextEditingController();
  bool isSearching = false;
  String search = '';
  int currentPage = 0;
  List<Books> books = [];
  int totalElements = 0;
  bool isLoadingNextPage = false;
  bool hasMorePages = true;

  final ScrollController _scrollController = ScrollController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    _fetchReaderBooks();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    _debounce?.cancel();
    super.dispose();
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Book'),
        surfaceTintColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Stack(
        children: [
          Container(
            color: Colors.grey[200]!,
            margin: const EdgeInsets.only(top: 80),
            child: books.isEmpty
                ? Center(
                    child: LoadingAnimationWidget.staggeredDotsWave(
                      color: Colors.green,
                      size: 60,
                    ),
                  )
                : ListView.builder(
                    controller: _scrollController,
                    itemCount: books.length + (isLoadingNextPage ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index == books.length) {
                        // Show loading indicator at the bottom
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                              child: LoadingAnimationWidget.prograssiveDots(
                            color: Colors.green,
                            size: 50,
                          )),
                        );
                      } else {
                        var book = books[index];
                        return InkWell(
                          onTap: () {
                            if (book.book != null) {
                              Navigator.of(context).push(
                                PageTransition(
                                  child: ReaderBookDetailWidget(
                                    book: book.book!,
                                    onSelected: widget.onSelected,
                                  ),
                                  type: PageTransitionType.rightToLeft,
                                  duration: const Duration(milliseconds: 300),
                                ),
                              );
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[200]!,
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
                                      image: NetworkImage(book
                                              .book?.smallThumbnailUrl ??
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                          ),
                        );
                      }
                    },
                  ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.white,
              child: Theme(
                data: ThemeData(
                  splashFactory: NoSplash.splashFactory,
                ),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: SearchBar(
                    autoFocus: true,
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        // Clear the previous search results
                        setState(() {
                          books.clear();
                          currentPage = 0;
                          hasMorePages = true;
                          isSearching = true;
                        });
                        if (_debounce?.isActive ?? false) _debounce?.cancel();
                        _debounce =
                            Timer(const Duration(milliseconds: 300), () {
                          // Fetch new data based on the new query
                          setState(() {
                            search = value;
                          });
                          _fetchReaderBooks();
                        });
                      } else {
                        // If the search query is empty, reset to default query 'a'
                        setState(() {
                          isSearching = false;
                          search = "";
                        });
                      }
                    },
                    controller: searchController,
                    trailing: [
                      SizedBox.square(
                        dimension: 25,
                        child: IconButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              Colors.grey.shade400,
                            ),
                            iconSize: MaterialStateProperty.all(12),
                            padding: MaterialStateProperty.all(
                              const EdgeInsets.all(0),
                            ),
                          ),
                          icon: Icon(
                            isSearching
                                ? UniconsLine.multiply
                                : UniconsLine.search,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            setState(() {
                              if (isSearching) {
                                // Clear the search text
                                searchController.clear();
                                // Stop searching
                                isSearching = false;
                                currentPage = 1;
                                hasMorePages = true;
                                books.clear();
                                search = "";
                                _fetchReaderBooks();
                              } else {
                                // Start searching
                                isSearching = true;
                              }
                            });
                          },
                        ),
                      ),
                    ],
                    constraints: const BoxConstraints(
                      maxHeight: 50,
                      minHeight: 50,
                      minWidth: 100,
                      maxWidth: 100,
                    ),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(14),
                        ),
                        side: BorderSide(
                          color: ColorHelper.getColor(ColorHelper.green),
                          width: 2,
                        ),
                      ),
                    ),
                    surfaceTintColor: MaterialStateProperty.all(Colors.white),
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                    shadowColor: MaterialStateProperty.all(
                      Colors.grey.withOpacity(0),
                    ),
                    textStyle: MaterialStateProperty.all(
                      const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                    ),
                    hintText: 'Search for products...',
                    hintStyle: MaterialStateProperty.all(
                      const TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
