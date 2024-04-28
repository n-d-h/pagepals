import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pagepals/helpers/color_helper.dart';
import 'package:unicons/unicons.dart';

class BookTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final String hint;
  final String? initValue;
  final int? maxLines;
  final Function()? onTap;

  const BookTextFormField({
    Key? key,
    this.controller,
    required this.hint,
    this.initValue,
    this.onTap,
    this.maxLines = 1,
  }) : super(key: key);

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
            'Book',
            style: const TextStyle(
                fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black),
          ),
        ),
        TextFormField(
          onTap: onTap,
          readOnly: true,
          initialValue: initValue,
          style: const TextStyle(
            color: Colors.black,
          ),
          controller: controller,
          keyboardType: TextInputType.text,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(fontSize: 16, color: Colors.grey),
            prefixIcon: Icon(
              UniconsLine.books,
              color: ColorHelper.getColor(ColorHelper.green),
            ),
            suffixIcon: Icon(
              Icons.arrow_right_alt,
              size: 35,
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
        ),
      ],
    );
  }
}
