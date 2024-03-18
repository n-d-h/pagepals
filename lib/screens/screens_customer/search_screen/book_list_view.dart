import 'package:flutter/material.dart';
import 'package:pagepals/models/book_model.dart';
import 'package:pagepals/services/book_service.dart';
import 'package:pagepals/widgets/text_widget.dart';

class BookListView extends StatefulWidget {
  const BookListView({Key? key});

  @override
  State<BookListView> createState() => _BookListViewState();
}

class _BookListViewState extends State<BookListView> {
  List<BookModel> books = [];

  @override
  void initState() {
    super.initState();
    books = [];
  }

  @override
  Widget build(BuildContext context) {
    Future<List<BookModel>> getListBooks() async {
      var books = await BookService.getAllBooks();
      return books;
    }

    return FutureBuilder<List<BookModel>>(
      future: getListBooks(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else if (snapshot.hasData) {
          books = snapshot.data!;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: books.map((book) {
              return Container(
                width: MediaQuery.of(context).size.width * 0.9,
                padding: const EdgeInsets.all(5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image(
                      image: NetworkImage(book.thumbnailUrl ?? ''),
                      fit: BoxFit.contain,
                      width: 100,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        TextWidget(
                          length: 200,
                          content: book.title,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          softWrap: false,
                          fontWeight: FontWeight.bold,
                        ),
                        TextWidget(
                          length: 200,
                          content: 'Category: ${book.bookCategories?[0].name ?? ''}',
                          overflow: TextOverflow.ellipsis,
                          fontSize: 14,
                          maxLines: 1,
                          softWrap: false,
                        ),
                        TextWidget(
                          length: 230,
                          content: book.bookAuthors?[0].name ?? '',
                          overflow: TextOverflow.ellipsis,
                          fontSize: 14,
                          maxLines: 1,
                          softWrap: false,
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
          );
        } else {
          return const Center(
            child: Text('No data'),
          );
        }
      },
    );
  }
}
