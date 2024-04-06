import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pagepals/helpers/color_helper.dart';
import 'package:pagepals/models/book_models/customer_book.dart';
import 'package:pagepals/screens/screens_customer/search_screen/book_list_view.dart';
import 'package:pagepals/screens/screens_customer/search_screen/category_list_view.dart';
import 'package:pagepals/services/book_service.dart';
import 'package:pagepals/widgets/text_widget.dart';

class BookTabScreen extends StatefulWidget {
  const BookTabScreen({super.key});

  @override
  State<BookTabScreen> createState() => _BookTabScreenState();
}

class _BookTabScreenState extends State<BookTabScreen> {
  int currentPage = 0;
  List<Book> books = [];
  bool isLoadingNextPage = false;
  bool hasMorePages = true;

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
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _fetchNextPage();
    }
  }

  Future<void> _fetchCustomerBooks() async {
    try {
      CustomerBook result =
          await BookService.getAllBooks("", "", currentPage, 10, "", "desc");
      setState(() {
        books.addAll(result.list!);
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
        CustomerBook result =
            await BookService.getAllBooks("", "", currentPage, 10, "", "desc");
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
    Future<CustomerBook> getBookModel() async {
      return await BookService.getAllBooks("", "", currentPage, 10, "", "");
    }

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
        : Scaffold(
            backgroundColor: Colors.grey[200]!,
            body: ListView.builder(
              controller: _scrollController,
              itemCount: books.length + (isLoadingNextPage ? 1 : 0),
              itemBuilder: (context, index) {
                if(index == books.length){
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
                              image: NetworkImage(book.smallThumbnailUrl ??
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
                                  crossAxisAlignment: WrapCrossAlignment.start,
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
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 3),
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
                  );
                }
              },
            ),
          );
  }
}

/*
FutureBuilder<CustomerBook>(
      future: getBookModel(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: LoadingAnimationWidget.staggeredDotsWave(
                color: ColorHelper.getColor(ColorHelper.green),
                size: 60,
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: Text('Error: ${snapshot.error}'),
            ),
          );
        } else if (snapshot.hasData) {
          final bookModel = snapshot.data!;
          return Scaffold(
            backgroundColor: Colors.grey[200]!,
            body: ListView.builder(
              itemCount: bookModel.list!.length,
              itemBuilder: (context, index) {
                final book = bookModel.list![index];
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
                            image: NetworkImage(book.smallThumbnailUrl ??
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
                              book.title ?? '',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                              softWrap: false,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),

                            // want  to map categories here and put them in a wrap
                            Container(
                              margin: const EdgeInsets.only(top: 5),
                              child: Wrap(
                                alignment: WrapAlignment.start,
                                crossAxisAlignment: WrapCrossAlignment.start,
                                spacing: 6.0,
                                // gap between adjacent chips
                                runSpacing: 6.0,
                                // gap between lines
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
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 3),
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
                );
              },
            ),
          );
        } else {
          return const Center(
            child: Text('No data'),
          );
        }
      },
    )
* */
