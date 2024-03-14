import 'package:flutter/material.dart';
import 'package:pagepals/models/category_model.dart';
import 'package:pagepals/services/category_service.dart';
import 'package:unicons/unicons.dart';

class CategoryListView extends StatefulWidget {
  const CategoryListView({super.key});

  @override
  State<CategoryListView> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<CategoryListView> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();

    Future<List<CategoryModel>> getAllCategory() {
      return CategoryService.getAllCategory();
    }

    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
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
            return SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              height: 120,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final category = snapshot.data![index];
                  return Container(
                    width: 235,
                    margin: const EdgeInsets.only(right: 20.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      border: Border.all(
                        color: Colors.grey.shade300,
                        width: 3.0,
                      ),
                      // image: const DecorationImage(
                      //   image: AssetImage('assets/reading_book.jpg'),
                      //   fit: BoxFit.cover,
                      // ),
                      gradient: const LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          Colors.blue,
                          Colors.red,
                        ],
                      ),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      fit: StackFit.expand,
                      children: [
                        Center(
                          child: ListTile(
                            title: Text(
                              category.name ?? '',
                              style: const TextStyle(
                                color: Colors.amberAccent,
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                              ),
                            ),
                            subtitle: Text(
                              category.description ?? '',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
