import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pagepals/helpers/color_helper.dart';
import 'package:pagepals/models/book_models/book_model.dart';
import 'package:unicons/unicons.dart';

class DropdownButtonWidget extends StatefulWidget {
  final String title;
  final List<Book> items;
  final String? value;
  final Function(String?) onValueChanged;

  const DropdownButtonWidget(
      {super.key,
      required this.title,
      required this.items,
      required this.onValueChanged,
      this.value});

  @override
  State<DropdownButtonWidget> createState() => _DropdownButtonWidgetState();
}

class _DropdownButtonWidgetState extends State<DropdownButtonWidget> {
  // late List<String> items;
  late List<Book> items;

  String? selectedItem;
  late String title;
  final TextEditingController textEditingController = TextEditingController();

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    title = widget.title;
    items = widget.items;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(
          height: 30,
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 15),
          height: 28,
          child: Text(
            title,
            style: const TextStyle(
                fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black),
          ),
        ),
        DropdownButtonFormField2<String>(
          value: widget.value,
          isExpanded: true,
          selectedItemBuilder: (value) {
            return items.map<Widget>(
              (e) {
                return Text(
                  e.title ?? 'book',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: Colors.black87,
                    overflow: TextOverflow.ellipsis,
                  ),
                );
              },
            ).toList();
          },
          decoration: InputDecoration(
            prefixIcon: Icon(
              UniconsLine.books,
              color: ColorHelper.getColor(ColorHelper.green),
            ),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 15, horizontal: 12),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black12, width: 1),
              borderRadius: BorderRadius.circular(12),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: ColorHelper.getColor(ColorHelper.green), width: 2),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          hint: const Text(
            'Select Item',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          items: items
              .map(
                (item) => DropdownMenuItem<String>(
                  value: item.id,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image(
                          image: NetworkImage(item.thumbnailUrl ?? ''),
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
                          item.title ?? 'book',
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    print('Tapped');
                  },
                ),
              )
              .toList(),
          validator: (value) {
            if (value == null) {
              return 'Please select an item.';
            }
            return null;
          },
          onChanged: (value) {
            // Update selectedGender to control the visibility of the icon
            setState(() {
              selectedItem = value;
              // print('item: ${value.toString()}');
            });
            widget.onValueChanged(selectedItem);
          },
          // onSaved: (value) {
          //   selectedItem = value.toString();
          //   widget.onValueChanged(selectedItem);
          // },

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
                  textEditingController.text = value;
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
                  suffixIcon: Theme(
                    data: ThemeData(
                      splashFactory: NoSplash.splashFactory,
                    ),
                    child: IconButton(
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
            searchMatchFn: (item, searchValue) {
              return item.value.toString().contains(searchValue);
            },
          ),
          //This to clear the search value when you close the menu
          onMenuStateChange: (isOpen) {
            if (!isOpen) {
              textEditingController.clear();
            }
          },
          buttonStyleData: const ButtonStyleData(
            padding: EdgeInsets.only(right: 8),
          ),
          iconStyleData: IconStyleData(
            icon: Icon(
              FontAwesomeIcons.angleDown,
              color: ColorHelper.getColor(ColorHelper.green),
            ),
            iconSize: 24,
          ),
          dropdownStyleData: DropdownStyleData(
            width: MediaQuery.of(context).size.width - 32,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
            ),
            maxHeight: 380,
          ),
          menuItemStyleData: const MenuItemStyleData(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            height: 120,
          ),
        ),
      ],
    );
  }
}
