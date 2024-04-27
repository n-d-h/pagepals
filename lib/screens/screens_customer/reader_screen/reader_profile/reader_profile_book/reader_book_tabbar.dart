import 'package:flutter/material.dart';
import 'package:pagepals/helpers/space_helper.dart';
import 'package:pagepals/models/book_models/book_model.dart';
import 'package:pagepals/screens/screens_customer/reader_screen/reader_profile/reader_profile_book/book_collection_widget.dart';
import 'package:pagepals/services/book_service.dart';

class ReaderBookTabbar extends StatefulWidget {
  const ReaderBookTabbar({super.key});

  @override
  State<ReaderBookTabbar> createState() => _ReaderBookTabbarState();
}

class _ReaderBookTabbarState extends State<ReaderBookTabbar> {
  // int currentPage = 0;
  // List<Books> books = [];
  // bool isLoadingNextPage = false;
  // bool hasMorePages = true;
  // String search = '';
  //
  // final ScrollController _scrollController = ScrollController();
  //
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   _scrollController.addListener(_scrollListener);
  //   _fetchCustomerBooks();
  // }
  //
  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   super.dispose();
  //   _scrollController.removeListener(_scrollListener);
  //   _scrollController.dispose();
  // }
  //
  // void _scrollListener() {
  //   if (_scrollController.position.pixels ==
  //       _scrollController.position.maxScrollExtent) {
  //     _fetchNextPage();
  //   }
  // }
  //
  // Future<void> _fetchCustomerBooks() async {
  //   try {
  //     BookModel result = await BookService.getReaderBooks()
  //     setState(() {
  //       books.addAll(result.list!);
  //       currentPage++;
  //       if (result.list!.isEmpty) {
  //         hasMorePages = false;
  //       }
  //     });
  //   } catch (e) {
  //     print(e);
  //   }
  // }
  //
  // Future<void> _fetchNextPage() async {
  //   if (!isLoadingNextPage && hasMorePages) {
  //     setState(() {
  //       isLoadingNextPage = true;
  //     });
  //     try {
  //       CustomerBook result = await BookService.getAllBooks(
  //           "", "", currentPage, 10, "${widget.search ?? ''}", "desc");
  //       if (result.list!.isEmpty) {
  //         setState(() {
  //           hasMorePages = false;
  //           isLoadingNextPage = false;
  //         });
  //       } else {
  //         setState(() {
  //           books.addAll(result.list!);
  //           currentPage++;
  //           isLoadingNextPage = false;
  //         });
  //       }
  //     } catch (error) {
  //       print("Error fetching next page: $error");
  //       setState(() {
  //         isLoadingNextPage = false;
  //       });
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        padding: const EdgeInsets.all(SpaceHelper.space16),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            BookCollectionWidget(),
            BookCollectionWidget(),
            BookCollectionWidget(),
            BookCollectionWidget(),
            BookCollectionWidget(),
          ],
        ),
      ),
    );
  }
}
