import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pagepals/helpers/color_helper.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final String label;
  final bool? isDigit;
  final String? initValue;
  final bool? readOnly;
  final Function()? onTap;

  const CustomTextFormField({
    Key? key,
    this.controller,
    required this.label,
    this.isDigit,
    this.initValue,
    this.readOnly, this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      readOnly: readOnly != null && readOnly == true,
      initialValue: initValue,
      style: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w600,
      ),
      controller: controller,
      keyboardType: isDigit != null && isDigit == true
          ? TextInputType.number
          : TextInputType.text,
      inputFormatters:
          isDigit == true ? [FilteringTextInputFormatter.digitsOnly] : null,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(
          color: Colors.grey,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: ColorHelper.getColor(ColorHelper.grey),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: ColorHelper.getColor(ColorHelper.grey),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
