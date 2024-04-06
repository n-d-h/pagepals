import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:pagepals/helpers/color_helper.dart';

class ReaderRequestDropdown extends StatefulWidget {
  final String title;
  final List<String> items;
  final String? value;
  final double? maxHeight;
  final Function(String?) onValueChanged;

  const ReaderRequestDropdown({
    super.key,
    required this.title,
    required this.items,
    required this.onValueChanged,
    this.value,
    this.maxHeight,
  });

  @override
  State<ReaderRequestDropdown> createState() => _ReaderRequestDropdownState();
}

class _ReaderRequestDropdownState extends State<ReaderRequestDropdown> {
  final TextEditingController textEditingController = TextEditingController();
  String? selectedItem;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    textEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField2<String>(
      value: widget.value,
      isExpanded: true,
      decoration: InputDecoration(
        label: widget.value != null || selectedItem != null
            ? Text(
                widget.title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  color: Colors.grey,
                ),
              )
            : null,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black12, width: 1),
          // borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: ColorHelper.getColor(ColorHelper.green), width: 2),
          // borderRadius: BorderRadius.circular(12),
        ),
      ),
      hint: Text(
        widget.title,
        style: const TextStyle(fontSize: 16, color: Colors.grey),
      ),
      items: widget.items
          .map(
            (item) => DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  color: Colors.black87,
                  overflow: TextOverflow.ellipsis,
                ),
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
        setState(() {
          selectedItem = value;
          // print('item: ${value.toString()}');
        });
        widget.onValueChanged(selectedItem);
      },

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
              hintText: 'Search for a ${widget.title.toLowerCase()}...',
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
          return item.value
              .toString()
              .toLowerCase()
              .contains(searchValue.toLowerCase());
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
      iconStyleData: const IconStyleData(
        icon: Icon(
          Icons.arrow_drop_down,
          color: Colors.grey,
        ),
        iconSize: 24,
      ),
      dropdownStyleData: DropdownStyleData(
        width: MediaQuery.of(context).size.width - 32,
        isOverButton: true,
        // useSafeArea: true,
        maxHeight: widget.maxHeight,
      ),
      menuItemStyleData: const MenuItemStyleData(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        // height: 120,
      ),
    );
  }
}
