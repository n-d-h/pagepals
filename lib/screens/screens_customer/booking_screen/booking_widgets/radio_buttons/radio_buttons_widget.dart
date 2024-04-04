import 'package:flutter/material.dart';
import 'package:pagepals/screens/screens_customer/booking_screen/booking_widgets/radio_buttons/radio_button.dart';

class RadioButtonsWidget extends StatefulWidget {
  final Function(int)? onValueChanged;

  const RadioButtonsWidget({super.key, this.onValueChanged});

  @override
  State<RadioButtonsWidget> createState() => _RadioButtonsWidgetState();
}

class _RadioButtonsWidgetState extends State<RadioButtonsWidget> {
  int? _selectedValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Services type',
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RadioButton(
              text: 'Read book',
              groupValue: _selectedValue,
              value: 1,
              onChanged: (value) {
                setState(() {
                  _selectedValue = value;
                });
                widget.onValueChanged?.call(value!);
              },
            ),
            RadioButton(
              text: 'Book explaining, brief book content',
              groupValue: _selectedValue,
              value: 2,
              onChanged: (value) {
                setState(() {
                  _selectedValue = value;
                });
                widget.onValueChanged?.call(value!);
              },
            ),
            RadioButton(
              text: 'Not one of above?',
              groupValue: _selectedValue,
              value: 3,
              onChanged: (value) {
                setState(() {
                  _selectedValue = value;
                });
                widget.onValueChanged?.call(value!);
              },
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        )
      ],
    );
  }
}
