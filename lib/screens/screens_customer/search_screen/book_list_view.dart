import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pagepals/helpers/color_helper.dart';
import 'package:pagepals/models/book_model.dart';
import 'package:pagepals/models/book_models/customer_book.dart';
import 'package:pagepals/services/book_service.dart';
import 'package:pagepals/widgets/text_widget.dart';

class BookListView extends StatefulWidget {
  const BookListView({super.key});

  @override
  State<BookListView> createState() => _BookListViewState();
}

class _BookListViewState extends State<BookListView> {
  CustomerBook? bookModel;

  @override
  Widget build(BuildContext context) {
    Future<CustomerBook> getBookModel() async {
      var bookModel = await BookService.getAllBooks("","",0, 10, "", "desc");
      return bookModel;
    }

    return FutureBuilder<CustomerBook>(
      future: getBookModel(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            margin:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.3),
            child: Center(
              child: LoadingAnimationWidget.staggeredDotsWave(
                color: ColorHelper.getColor(ColorHelper.green),
                size: 60,
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Container(
            margin:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.3),
            child: Center(
              child: Text('Error: ${snapshot.error}'),
            ),
          );
        } else if (snapshot.hasData) {
          bookModel = snapshot.data!;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: bookModel!.list!.map((book) {
              return Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 100,
                      height: 140,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: NetworkImage(book.smallThumbnailUrl ??
                              "https://via.placeholder.com/150"),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // TextWidget(
                          //   length: 200,
                          //   content: book.title ?? '',
                          //   overflow: TextOverflow.ellipsis,
                          //   maxLines: 3,
                          //   softWrap: false,
                          //   fontWeight: FontWeight.bold,
                          // ),
                          Text(
                            book.title ?? '',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                            softWrap: false,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextWidget(
                            length: 200,
                            content:
                                'Category: ${book.categories?[0].name ?? ''}',
                            overflow: TextOverflow.ellipsis,
                            fontSize: 14,
                            maxLines: 1,
                            softWrap: false,
                          ),
                          TextWidget(
                            length: 230,
                            content: book.categories?[0].name ?? '',
                            overflow: TextOverflow.ellipsis,
                            fontSize: 14,
                            maxLines: 1,
                            softWrap: false,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          );
        } else {
          return const Center(
            child: Text('No data'),
          );
        }
      },
    );
  }
}
