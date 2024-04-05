import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pagepals/helpers/color_helper.dart';
import 'package:unicons/unicons.dart';

class SelectServiceDropdown extends StatefulWidget {
  final String title;
  final int opt;
  final List<DropdownMenuItem<String>>? items;
  final Function(String?) onValueChanged;
  final List<Widget> Function(BuildContext)? selectedItemBuilder;

  const SelectServiceDropdown({
    super.key,
    required this.opt,
    required this.title,
    required this.items,
    required this.onValueChanged,
    this.selectedItemBuilder,
  });

  @override
  State<SelectServiceDropdown> createState() => _DropdownButtonWidgetState();
}

class _DropdownButtonWidgetState extends State<SelectServiceDropdown> {
  late List<DropdownMenuItem<String>> items;

  String? selectedItem;
  late int opt;
  late String title;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    opt = widget.opt;
    title = widget.title;
    items = widget.items!;
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
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ),
        DropdownButtonFormField2<String>(
          isExpanded: true,
          selectedItemBuilder: widget.selectedItemBuilder,
          decoration: InputDecoration(
            prefixIcon: opt == 1
                ? Icon(
                    UniconsLine.clipboard_notes,
                    color: ColorHelper.getColor(ColorHelper.green),
                  )
                : opt == 2
                    ? Icon(
                        UniconsLine.clipboard_alt,
                        color: ColorHelper.getColor(ColorHelper.green),
                      )
                    : null,
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
          items: items,
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
              maxHeight: 160),
          menuItemStyleData: const MenuItemStyleData(
            padding: EdgeInsets.symmetric(horizontal: 20),
            // height: 120,
          ),
        ),
      ],
    );
  }
}
