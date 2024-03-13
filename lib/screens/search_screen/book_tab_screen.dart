import 'package:flutter/material.dart';
import 'package:pagepals/screens/search_screen/book_list_view.dart';
import 'package:pagepals/screens/search_screen/category_list_view.dart';

class BookTabScreen extends StatelessWidget {
  const BookTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.vertical,
      children: const [
        CategoryListView(),
        BookListView(),
        SizedBox(height: 80),
      ],
    );
  }
}

