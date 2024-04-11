import 'package:flutter/material.dart';
import 'package:pagepals/models/google_book.dart';
import 'package:pagepals/screens/screens_customer/book_screen/book_detail_widgets/book_description.dart';
import 'package:pagepals/screens/screens_customer/book_screen/book_detail_widgets/book_image_widget.dart';
import 'package:pagepals/screens/screens_customer/book_screen/book_detail_widgets/book_info_widget.dart';
import 'package:unicons/unicons.dart';

class GoogleBookDetailScreen extends StatelessWidget {
  final GoogleBookModel book;
  final Function(GoogleBookModel?)? onTap;

  const GoogleBookDetailScreen({super.key, required this.book, this.onTap});

  @override
  Widget build(BuildContext context) {
    // Get the authors from the book object
    String? authors = book.volumeInfo?.authors?.map((e) => e).join(', ');

    // Get the categories from the book object
    String? categories = book.volumeInfo?.categories?.map((e) => e).join(', ');

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
            BookImage(url: book.volumeInfo?.imageLinks?.thumbnail),
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
                      book.volumeInfo?.title ?? 'Book title',
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
                  BookDescription(description: book.volumeInfo?.description),
                  const SizedBox(height: 20),
                  Center(
                    child: OutlinedButton(
                      onPressed: () {
                        onTap!(book);
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
