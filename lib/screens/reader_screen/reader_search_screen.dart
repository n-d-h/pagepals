import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';

class ReaderSearchScreen extends StatefulWidget {
  const ReaderSearchScreen({super.key});

  @override
  State<ReaderSearchScreen> createState() => _ReaderSearchScreenState();
}

class _ReaderSearchScreenState extends State<ReaderSearchScreen> {
  @override
  Widget build(BuildContext context) {

    final TextEditingController searchController = TextEditingController();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          toolbarHeight: 70,
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          flexibleSpace: Container(
            margin: const EdgeInsets.all(10),
            child: Row(
              children: [
                SearchBar(
                  autoFocus: true,
                  onChanged: (value) {
                    print('Searching for: $value');
                  },
                  onSubmitted: (value) {
                    print('Submit Searching for: $value');
                  },
                  controller: searchController,
                  leading: IconButton(
                    icon: const Icon(UniconsLine.search),
                    onPressed: () {
                      print('Searching for: ${searchController.text}');
                    },
                  ),
                  trailing: [
                    IconButton(
                      icon: const Icon(UniconsLine.multiply),
                      onPressed: () {
                        searchController.clear();
                      },
                    ),
                  ],
                  constraints: const BoxConstraints(
                    maxHeight: 50,
                    maxWidth: 310,
                  ),
                  shadowColor:
                  MaterialStateProperty.all(Colors.grey.withOpacity(0)),
                  textStyle: MaterialStateProperty.all(
                    const TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  hintText: 'Search for a reader',
                ),
                const SizedBox(width: 15),
                InkWell(
                  onTap: () {
                    print('Filter button pressed');
                  },
                  borderRadius: BorderRadius.circular(10),
                  child: const Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Icon(UniconsLine.filter),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Container(
                  margin: const EdgeInsets.only(top: 50),
                  child: Text(
                    'Search for a reader',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
