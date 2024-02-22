import 'package:flutter/material.dart';
import 'package:pagepals/screens/search_screen/book_tab_screen.dart';
import 'package:pagepals/screens/search_screen/reader_tab_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text(
            'Search',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Reader'),
              Tab(text: 'Books'),
            ],
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.search_rounded,
                color: Colors.black,
              ),
            ),
          ],
        ),
        body: TabBarView(
          children: [
            ReaderTabScreen(),
            BookTabScreen()
          ],
        ),
      ),
    );
  }
}
