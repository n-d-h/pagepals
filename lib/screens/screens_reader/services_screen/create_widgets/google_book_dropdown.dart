// import 'dart:convert';
//
// import 'package:dropdown_button2/dropdown_button2.dart';
// import 'package:flutter/material.dart';
// import 'package:pagepals/helpers/color_helper.dart';
// import 'package:pagepals/models/google_book.dart';
// import 'package:pagepals/services/book_service.dart';
//
// class GoogleBookDropdown extends StatefulWidget {
//   final Function(String?)? onChanged;
//
//   const GoogleBookDropdown({super.key, this.onChanged});
//
//   @override
//   State<GoogleBookDropdown> createState() => _GoogleBookDropdownState();
// }
//
// class _GoogleBookDropdownState extends State<GoogleBookDropdown> {
//   List<GoogleBookModel> googleBooks = [];
//   bool isSelected = false;
//
//   Future<void> getGoogleBooks() async {
//     List<GoogleBookModel> result =
//     await BookService.getGoogleBooks("a", "a", 1, 10);
//     setState(() {
//       googleBooks = result;
//     });
//   }
//
//   final TextEditingController textEditingController = TextEditingController();
//
//   @override
//   void dispose() {
//     textEditingController.dispose();
//     super.dispose();
//   }
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     getGoogleBooks();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return DropdownButtonFormField2<String>(
//       isExpanded: true,
//       selectedItemBuilder: (BuildContext context) {
//         return googleBooks
//             .map((item) => Text(
//                   item.volumeInfo?.title ?? 'GG Book title',
//                   style: const TextStyle(
//                       overflow: TextOverflow.ellipsis,
//                       fontSize: 16,
//                       fontWeight: FontWeight.w600),
//                 ))
//             .toList();
//       },
//       decoration: InputDecoration(
//         labelText: isSelected ? 'Book' : null,
//         labelStyle: TextStyle(
//           color: Colors.black45.withOpacity(0.4),
//         ),
//         contentPadding:
//             const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
//         enabledBorder: OutlineInputBorder(
//           borderSide: BorderSide(
//               color: ColorHelper.getColor(ColorHelper.grey), width: 1),
//           borderRadius: BorderRadius.circular(12),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderSide: BorderSide(
//               color: ColorHelper.getColor(ColorHelper.green), width: 2),
//           borderRadius: BorderRadius.circular(12),
//         ),
//       ),
//       hint: const Text(
//         'Book',
//         style: TextStyle(fontSize: 16, color: Colors.grey),
//       ),
//       dropdownSearchData: DropdownSearchData(
//         searchController: textEditingController,
//         searchInnerWidgetHeight: 55,
//         searchInnerWidget: Container(
//           height: 55,
//           padding: const EdgeInsets.only(
//             top: 8,
//             bottom: 0,
//             right: 12,
//             left: 12,
//           ),
//           child: TextFormField(
//             onChanged: (value) async {
//               // textEditingController.text = value;
//               List<GoogleBookModel> result = await BookService.getGoogleBooks("", value, 1, 10);
//               setState(() {
//                 googleBooks = result;
//               });
//               // setState(() {
//               //   title = value;
//               // });
//               //
//             },
//             expands: true,
//             maxLines: null,
//             controller: textEditingController,
//             decoration: InputDecoration(
//               isDense: true,
//               contentPadding: const EdgeInsets.symmetric(
//                 horizontal: 10,
//                 vertical: 8,
//               ),
//               hintText: 'Search for a book...',
//               hintStyle: const TextStyle(fontSize: 12),
//               enabledBorder: OutlineInputBorder(
//                 borderSide: const BorderSide(
//                   color: Colors.black54,
//                   width: 1,
//                 ),
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               focusedBorder: OutlineInputBorder(
//                 borderSide: BorderSide(
//                   color: ColorHelper.getColor(ColorHelper.green),
//                   width: 2,
//                 ),
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               suffixIcon: Theme(
//                 data: ThemeData(
//                   splashFactory: NoSplash.splashFactory,
//                 ),
//                 child: IconButton(
//                   padding: const EdgeInsets.all(0),
//                   onPressed: () {
//                     textEditingController.clear();
//                   },
//                   icon: const Icon(Icons.clear),
//                 ),
//               ),
//             ),
//           ),
//         ),
//         // searchMatchFn: (item, searchValue) {
//         //   return item.value.toString().contains(searchValue);
//         // },
//       ),
//       //This to clear the search value when you close the menu
//       onMenuStateChange: (isOpen) {
//         if (!isOpen) {
//           textEditingController.clear();
//         }
//       },
//       items: googleBooks
//           .map((item) => DropdownMenuItem<String>(
//                 value: json.encode(item),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     ClipRRect(
//                       borderRadius: BorderRadius.circular(12),
//                       child: Image(
//                         image: NetworkImage(
//                             item.volumeInfo?.imageLinks?.thumbnail ?? ''),
//                         fit: BoxFit.fill,
//                         width: 80,
//                         height: 100,
//                       ),
//                     ),
//                     const SizedBox(
//                       width: 10,
//                     ),
//                     Expanded(
//                       child: Text(
//                         item.volumeInfo?.title ?? 'GG Book title',
//                         maxLines: 3,
//                         style: const TextStyle(
//                             overflow: TextOverflow.clip,
//                             fontSize: 16,
//                             fontWeight: FontWeight.w600),
//                       ),
//                     ),
//                   ],
//                 ),
//               ))
//           .toList(),
//       validator: (value) {
//         if (value == null) {
//           return 'Please select book.';
//         }
//         return null;
//       },
//       onChanged: (value) {
//         // Update the selected book title when an item is selected
//         setState(() {
//           // selectedBookTitle = json.decode(value!)['volumeInfo']['title'];
//           isSelected = true;
//         });
//         // Pass the selected value to the parent widget's onChanged callback
//         widget.onChanged?.call(value);
//       },
//       buttonStyleData: const ButtonStyleData(
//         padding: EdgeInsets.only(right: 8),
//       ),
//       iconStyleData: const IconStyleData(
//         icon: Icon(
//           Icons.keyboard_arrow_down,
//           color: Colors.black45,
//         ),
//         iconSize: 24,
//       ),
//       dropdownStyleData: DropdownStyleData(
//         width: MediaQuery.of(context).size.width - 40,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(12),
//         ),
//         maxHeight: 500,
//       ),
//       menuItemStyleData: const MenuItemStyleData(
//         padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//         height: 120,
//       ),
//     );
//   }
// }
import 'dart:convert';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:pagepals/helpers/color_helper.dart';
import 'package:pagepals/models/google_book.dart';
import 'package:pagepals/services/book_service.dart';

class GoogleBookDropdown extends StatefulWidget {
  final Function(String?)? onChanged;

  const GoogleBookDropdown({Key? key, this.onChanged}) : super(key: key);

  @override
  State<GoogleBookDropdown> createState() => _GoogleBookDropdownState();
}

class _GoogleBookDropdownState extends State<GoogleBookDropdown> {
  List<GoogleBookModel> googleBooks = [];
  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getGoogleBooks("a");
  }

  Future<void> getGoogleBooks(String query) async {
    List<GoogleBookModel> result =
    await BookService.getGoogleBooks("a", query, 1, 10);
    setState(() {
      googleBooks = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField2<String>(
      key: UniqueKey(), // Add a unique key to force rebuild
      isExpanded: true,
      selectedItemBuilder: (BuildContext context) {
        return googleBooks
            .map((item) => Text(
          item.volumeInfo?.title ?? 'GG Book title',
          style: const TextStyle(
              overflow: TextOverflow.ellipsis,
              fontSize: 16,
              fontWeight: FontWeight.w600),
        ))
            .toList();
      },
      decoration: InputDecoration(
        labelText: 'Book',
        labelStyle: TextStyle(
          color: Colors.black45.withOpacity(0.4),
        ),
        contentPadding:
        const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: ColorHelper.getColor(ColorHelper.grey), width: 1),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: ColorHelper.getColor(ColorHelper.green), width: 2),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      hint: const Text(
        'Book',
        style: TextStyle(fontSize: 16, color: Colors.grey),
      ),
      dropdownSearchData: DropdownSearchData(
        searchController: textEditingController,
        searchInnerWidgetHeight: 55,
        searchInnerWidget: Container(
          height: 55,
          padding: const EdgeInsets.only(
            top: 8,
            bottom: 0,
            right: 12,
            left: 12,
          ),
          child: TextFormField(
            onChanged: (value) {
              getGoogleBooks(value);
            },
            expands: true,
            maxLines: null,
            controller: textEditingController,
            decoration: InputDecoration(
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 8,
              ),
              hintText: 'Search for a book...',
              hintStyle: const TextStyle(fontSize: 12),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.black54,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: ColorHelper.getColor(ColorHelper.green),
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              suffixIcon: IconButton(
                padding: const EdgeInsets.all(0),
                onPressed: () {
                  textEditingController.clear();
                },
                icon: const Icon(Icons.clear),
              ),
            ),
          ),
        ),
      ),
      onMenuStateChange: (isOpen) {
        if (!isOpen) {
          textEditingController.clear();
        }
      },
      items: googleBooks
          .map((item) => DropdownMenuItem<String>(
        value: json.encode(item),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image(
                image: NetworkImage(
                    item.volumeInfo?.imageLinks?.thumbnail ?? 'https://via.placeholder.com/150'),
                fit: BoxFit.fill,
                width: 80,
                height: 100,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text(
                item.volumeInfo?.title ?? 'GG Book title',
                maxLines: 3,
                style: const TextStyle(
                    overflow: TextOverflow.ellipsis,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ))
          .toList(),
      validator: (value) {
        if (value == null) {
          return 'Please select book.';
        }
        return null;
      },
      onChanged: (value) {
        setState(() {
          // Do something with the selected value if needed
        });
        widget.onChanged?.call(value);
      },
      buttonStyleData: const ButtonStyleData(
        padding: EdgeInsets.only(right: 8),
      ),
      iconStyleData: const IconStyleData(
        icon: Icon(
          Icons.keyboard_arrow_down,
          color: Colors.black45,
        ),
        iconSize: 24,
      ),
      dropdownStyleData: DropdownStyleData(
        width: MediaQuery.of(context).size.width - 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        maxHeight: 500,
      ),
      menuItemStyleData: const MenuItemStyleData(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        height: 120,
      ),
    );
  }
}

