import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pagepals/models/book_models/book_model.dart';
import 'package:pagepals/models/google_book.dart';
import 'package:pagepals/screens/screens_customer/book_screen/book_detail_widgets/book_description.dart';
import 'package:pagepals/screens/screens_customer/book_screen/book_detail_widgets/book_image_widget.dart';
import 'package:pagepals/screens/screens_customer/book_screen/book_detail_widgets/book_info_widget.dart';
import 'package:pagepals/screens/screens_customer/book_screen/google_book_detail.dart';
import 'package:unicons/unicons.dart';

class ReaderBookDetailWidget extends StatelessWidget {
  final Function(String) onSelected;
  final Book book;

  const ReaderBookDetailWidget(
      {super.key, required this.book, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    // Get the authors from the book object
    String? authors = book.authors?.map((e) => e.name).join(', ');

    // Get the categories from the book object
    String? categories = book.categories?.map((e) => e.name).join(', ');

    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
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
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
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
                  const SizedBox(height: 20),
                  Center(
                    child: OutlinedButton(
                      onPressed: () {
                        onSelected(book.id!);
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.blue,
                        side: const BorderSide(color: Colors.blue, width: 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text('Choose Book'),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
