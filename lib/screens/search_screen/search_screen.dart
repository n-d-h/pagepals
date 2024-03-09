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
          surfaceTintColor: Colors.white,
          backgroundColor: Colors.white,
          title: Row(
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
                    icon: const Icon(Icons.clear),
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
              GestureDetector(
                onTap: () {
                  print('Filter button pressed');
                },
                child: Container(
                  padding: const EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(UniconsLine.filter),
                ),
              ),
            ],
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          controller: ScrollController(),
          physics: const BouncingScrollPhysics(),
          child: Container(
            margin: const EdgeInsets.all(10.0),
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
