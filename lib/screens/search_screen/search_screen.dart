import 'package:flutter/material.dart';
import 'package:pagepals/models/category_model.dart';
import 'package:pagepals/services/category_service.dart';
import 'package:unicons/unicons.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();

    Future<List<CategoryModel>> getAllCategory() {
      return CategoryService.getAllCategory();
    }

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
          controller: ScrollController(),
          physics: const BouncingScrollPhysics(),
          child: Container(
            margin: const EdgeInsets.fromLTRB(10, 15, 10, 70),
            padding: const EdgeInsets.all(10.0),
            height: MediaQuery.of(context).size.height,
            child: FutureBuilder<List<CategoryModel>>(
              future: getAllCategory(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Text('No categories found.');
                } else {
                  return GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
                    ),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final category = snapshot.data![index];
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          fit: StackFit.expand,
                          children: [
                            Image.asset(
                              'assets/reading_book.jpg',
                              fit: BoxFit.cover,
                            ),
                            Center(
                              child: ListTile(
                                title: Text(
                                  category.name ?? '',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0,
                                  ),
                                ),
                                subtitle: Text(
                                  category.description ?? '',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
