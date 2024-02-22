import 'package:flutter/material.dart';
import 'package:pagepals/helpers/color_helper.dart';
import 'package:pagepals/helpers/space_helper.dart';
import 'package:pagepals/models/book_model.dart';
import 'package:pagepals/services/book_service.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {

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


    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.clear_rounded,
            color: Colors.black,
          ),
        ),
        title: const Text(
          "Notification",
          style: TextStyle(
            color: Colors.black,
            fontSize: SpaceHelper.space24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        controller: ScrollController(),
        physics: const BouncingScrollPhysics(),
        child: FutureBuilder<List<BookModel>>(
          future: getListBooks(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  "Error: ${snapshot.error}",
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: SpaceHelper.space16,
                  ),
                ),
              );
            } else {
              books = snapshot.data!;
              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: books.length,
                itemBuilder: (context, index) {
                  return ListTile(
                      leading: CircleAvatar(
                        radius: SpaceHelper.space24,
                        backgroundColor: Colors.red,
                        child: Text(
                          books[index].title![0].toUpperCase(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: SpaceHelper.space24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      title: Text(
                        books[index].title!,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: SpaceHelper.space16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        books[index].author!,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: SpaceHelper.space14,
                        ),
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Colors.grey,
                      ),
                      onTap: () {}
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
