import 'package:flutter/material.dart';
import 'package:pagepals/models/book_models/customer_book.dart';
import 'package:pagepals/screens/screens_customer/book_screen/book_detail_widgets/book_description.dart';
import 'package:pagepals/screens/screens_customer/book_screen/book_detail_widgets/book_image_widget.dart';
import 'package:pagepals/screens/screens_customer/book_screen/book_detail_widgets/book_info_widget.dart';
import 'package:pagepals/screens/screens_customer/book_screen/book_detail_widgets/book_service_box.dart';
import 'package:unicons/unicons.dart';
import 'package:pagepals/models/book_models/book_model.dart' as book_model;

class BookDetailScreen extends StatelessWidget {
  final Book book;

  const BookDetailScreen({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    // Get the authors from the book object
    String? authors = book.authors?.map((e) => e.name).join(', ');

    // Get the categories from the book object
    String? categories = book.categories?.map((e) => e.name).join(', ');

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(UniconsLine.bookmark),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(UniconsLine.ellipsis_v),
          ),
        ],
      ),
      body: SingleChildScrollView(
        controller: ScrollController(),
        physics: const BouncingScrollPhysics(),
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 10),
                  BookImage(url: book.thumbnailUrl),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: Text(
                            textAlign: TextAlign.center,
                            book.title ?? 'Book title',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        BookInfo(title: 'Authors: ', info: authors),
                        const SizedBox(height: 20),
                        BookInfo(title: 'Categories: ', info: categories),
                        const SizedBox(height: 20),
                        BookDescription(description: book.description),
                      ],
                    ),
                  ),
                ],
              ),
            ),
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
              margin: const EdgeInsets.only(top: 10),
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Services related to this book',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 20),
                  BookServiceBox(
                    bookId: book.id,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
