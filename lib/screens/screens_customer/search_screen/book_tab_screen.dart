import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pagepals/helpers/color_helper.dart';
import 'package:pagepals/models/book_models/customer_book.dart';
import 'package:pagepals/screens/screens_customer/book_screen/book_detail_screen.dart';
import 'package:pagepals/services/book_service.dart';

class BookTabScreen extends StatefulWidget {
  final String? search;

  const BookTabScreen({super.key, this.search});

  @override
  State<BookTabScreen> createState() => _BookTabScreenState();
}

class _BookTabScreenState extends State<BookTabScreen> {
  int currentPage = 0;
  List<Book> books = [];
  bool isLoadingNextPage = false;
  bool hasMorePages = true;
  int totalOfElements = 0;
  Timer? _debounce;
  String search = '';

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    _fetchCustomerBooks();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    _debounce?.cancel();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        books.length < totalOfElements) {
      _fetchNextPage();
    }
  }

  Future<void> _fetchCustomerBooks() async {
    try {
      CustomerBook result = await BookService.getAllBooks(
          "", "", currentPage, 10, "${widget.search ?? ''}", "desc");
      setState(() {
        books.addAll(result.list!);
        totalOfElements = result.pagination?.totalOfElements ?? 0;
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
        CustomerBook result = await BookService.getAllBooks(
            "", "", currentPage, 10, "${widget.search ?? ''}", "desc");
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
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      if (search != widget.search) {
        setState(() {
          currentPage = 0;
          books.clear();
          hasMorePages = true;
          search = widget.search ?? '';
        });
        _fetchCustomerBooks();
      }
    });
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
        : books.first.id == null
            ? Scaffold(
                backgroundColor: Colors.white,
                body: Center(
                  child: Text("No results found"),
                ),
              )
            : Scaffold(
                backgroundColor: Colors.grey[200]!,
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
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.rightToLeft,
                              child: BookDetailScreen(book: book),
                              duration: const Duration(milliseconds: 300),
                            ),
                          );
                        },
                        child: Container(
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
                                      book.smallThumbnailUrl ??
                                          "https://via.placeholder.com/150",
                                    ),
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
                                      book.title ?? '',
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 3,
                                      softWrap: false,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(top: 5),
                                      child: Wrap(
                                        alignment: WrapAlignment.start,
                                        crossAxisAlignment:
                                            WrapCrossAlignment.start,
                                        spacing: 6.0,
                                        runSpacing: 6.0,
                                        children: book.categories!
                                            .map(
                                              (category) => Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  border: Border.all(
                                                    color: ColorHelper.getColor(
                                                        ColorHelper.green),
                                                  ),
                                                ),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 8,
                                                  vertical: 3,
                                                ),
                                                child: Text(
                                                  category.name ?? '',
                                                  style: GoogleFonts.openSans(
                                                    color: ColorHelper.getColor(
                                                        ColorHelper.green),
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                            )
                                            .toList(),
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
              );
  }
}
