import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:pagepals/helpers/color_helper.dart';
import 'package:pagepals/models/service_models/service_model.dart';
import 'package:pagepals/services/service_service.dart';

class ServiceTypeDropdown extends StatefulWidget {
  final Function(String?)? onChanged;
  final String? value;

  const ServiceTypeDropdown({super.key, this.onChanged, this.value});

  @override
  State<ServiceTypeDropdown> createState() => _State();
}

class _State extends State<ServiceTypeDropdown> {
  List<ServiceType> serviceTypes = [];
  bool isSelected = false;

  Future<void> getServiceTypes() async {
    var result = await ServiceService.getListServiceType();
    setState(() {
      serviceTypes = result;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getServiceTypes();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField2<String>(
      value: widget.value,
      isExpanded: true,
      decoration: InputDecoration(
        labelText: isSelected || widget.value != null ? 'Service Type' : null,
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
        'Service Type',
        style: TextStyle(fontSize: 16, color: Colors.grey),
      ),
      items: serviceTypes
          .map((item) => DropdownMenuItem<String>(
                value: item.id,
                child: Text(
                  item.name ?? 'Service',
                  style: const TextStyle(
                      overflow: TextOverflow.clip,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
              ))
          .toList(),
      validator: (value) {
        if (value == null) {
          return 'Please select service type.';
        }
        return null;
      },
      onChanged: (value) {
        // Update selectedGender to control the visibility of the icon
        setState(() {
          isSelected = true;
        });
        widget.onChanged?.call(value);
      },
      // onChanged: widget.onChanged,
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
      ),
      menuItemStyleData: const MenuItemStyleData(
        padding: EdgeInsets.symmetric(horizontal: 20),
      ),
    );
  }
}
