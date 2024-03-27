import 'dart:async';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pagepals/helpers/color_helper.dart';
import 'package:pagepals/models/google_book.dart';
import 'package:pagepals/screens/screens_reader/services_screen/create_widgets/google_book_widget.dart';
import 'package:pagepals/services/book_service.dart';
import 'package:unicons/unicons.dart';

class SearchBookScreen extends StatefulWidget {
  final Function(GoogleBookModel?)? onTap;

  const SearchBookScreen({Key? key, this.onTap}) : super(key: key);

  @override
  State<SearchBookScreen> createState() => _SearchBookScreenState();
}

class _SearchBookScreenState extends State<SearchBookScreen> {
  TextEditingController searchController = TextEditingController();
  bool isSearching = false;
  String query = 'a';
  int currentPage = 1;
  List<GoogleBookModel> googleBooks = [];
  bool isLoadingNextPage = false;
  bool hasMorePages = true;

  final ScrollController _scrollController = ScrollController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    _fetchGoogleBooks();
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
        _scrollController.position.maxScrollExtent) {
      _fetchNextPage();
    }
  }

  Future<void> _fetchGoogleBooks() async {
    try {
      List<GoogleBookModel> result =
          await BookService.getGoogleBooks("a", query, currentPage, 10);
      setState(() {
        googleBooks.addAll(result);
        currentPage++;
        if (result.isEmpty) {
          hasMorePages = false;
        }
      });
    } catch (error) {
      print("Error fetching books: $error");
    }
  }

  Future<void> _fetchNextPage() async {
    if (!isLoadingNextPage && hasMorePages) {
      setState(() {
        isLoadingNextPage = true;
      });
      try {
        List<GoogleBookModel> result =
            await BookService.getGoogleBooks("a", query, currentPage, 10);
        if (result.isEmpty) {
          setState(() {
            hasMorePages = false;
            isLoadingNextPage = false;
          });
        } else {
          setState(() {
            // Filter out duplicates before adding them to googleBooks
            final filteredResult = result.where((book) =>
                !googleBooks.any((existingBook) => existingBook.id == book.id));
            googleBooks.addAll(filteredResult);
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
            child: googleBooks.isEmpty
                ? Center(
                    child: LoadingAnimationWidget.staggeredDotsWave(
                      color: Colors.green,
                      size: 60,
                    ),
                  )
                : ListView.builder(
                    controller: _scrollController,
                    itemCount: googleBooks.length + (isLoadingNextPage ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index == googleBooks.length) {
                        // Show loading indicator at the bottom
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: LoadingAnimationWidget.prograssiveDots(
                              color: Colors.green,
                              size: 50,
                            )
                          ),
                        );
                      } else {
                        var ggBook = googleBooks[index];
                        return GoogleBookWidget(
                          book: ggBook,
                          onTap: widget.onTap,
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
                          googleBooks.clear();
                          currentPage = 1;
                          hasMorePages = true;
                          isSearching = true;
                        });
                        if (_debounce?.isActive ?? false) _debounce?.cancel();
                        _debounce =
                            Timer(const Duration(milliseconds: 300), () {
                          // Fetch new data based on the new query
                          setState(() {
                            query = value;
                          });
                          _fetchGoogleBooks();
                        });
                      } else {
                        // If the search query is empty, reset to default query 'a'
                        setState(() {
                          isSearching = false;
                          query = "a";
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
                                googleBooks.clear();
                                query = "a";
                                _fetchGoogleBooks();
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
