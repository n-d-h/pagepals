import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pagepals/helpers/color_helper.dart';
import 'package:pagepals/models/authen_models/account_model.dart';
import 'package:pagepals/services/customer_service.dart';

final customerEditFormKey = GlobalKey<FormState>();

class CustomerEditProfileScreen extends StatefulWidget {
  final AccountModel? account;

  const CustomerEditProfileScreen({super.key, this.account});

  @override
  State<CustomerEditProfileScreen> createState() =>
      _CustomerEditProfileScreenState();
}

class _CustomerEditProfileScreenState extends State<CustomerEditProfileScreen> {
  File? _selectedImage;
  List<String> gender = ["MALE", "FEMALE", "OTHER"];

  void _handleImageSelection() async {
    final result = await ImagePicker().pickImage(
      imageQuality: 70,
      maxWidth: 1440,
      maxHeight: 1440,
      source: ImageSource.gallery,
    );

    if (result != null) {
      setState(() {
        _selectedImage = File(result.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Customer customer = widget.account?.customer ?? Customer();
    TextEditingController fullNameController = TextEditingController(
      text: customer.fullName,
    );
    TextEditingController dobController = TextEditingController(
      text: customer.dob,
    );
    TextEditingController genderController = TextEditingController(
      text: customer.gender,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.account?.username}'),
        centerTitle: true,
        surfaceTintColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        controller: ScrollController(),
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    borderRadius: BorderRadius.circular(100),
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Container(
                            height: 150,
                            width: double.infinity,
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 20),
                                InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                    _handleImageSelection();
                                  },
                                  child: const Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Text(
                                      'Choose from Gallery',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Text(
                                      'Cancel',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: Stack(
                      children: [
                        _selectedImage != null
                            ? Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  image: DecorationImage(
                                    image: FileImage(_selectedImage!),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )
                            : CircleAvatar(
                                radius: 50,
                                backgroundImage: NetworkImage(
                                  customer?.imageUrl ?? '',
                                ),
                              ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            height: 35,
                            width: 35,
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.camera_alt,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Change Profile Picture',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Personal Information',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Form(
                key: customerEditFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: fullNameController,
                      decoration: const InputDecoration(
                        labelText: 'Full Name',
                        border: OutlineInputBorder(),
                      ),
                      onTapOutside: (e) {
                        FocusScope.of(context).unfocus();
                      },
                      onChanged: (value) {
                        fullNameController.text = value;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: dobController,
                      decoration: const InputDecoration(
                        labelText: 'Date of Birth',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.datetime,
                      onSaved: (value) {
                        dobController.text = value!;
                      },
                      onTapOutside: (e) {
                        FocusScope.of(context).unfocus();
                        dobController.text = dobController.text;
                      },
                    ),
                    const SizedBox(height: 20),
                    DropdownMenu<String>(
                      hintText: 'Country',
                      width: MediaQuery.of(context).size.width * 0.95,
                      label: const Text('Country'),
                      controller: genderController,
                      menuHeight: 300.0,
                      menuStyle: MenuStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white),
                        elevation: MaterialStateProperty.all(0),
                        side: MaterialStateProperty.all(
                          const BorderSide(color: Colors.grey),
                        ),
                      ),
                      onSelected: (String? value) {},
                      dropdownMenuEntries:
                          gender.map<DropdownMenuEntry<String>>((String value) {
                        return DropdownMenuEntry<String>(
                          value: value,
                          label: value,
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 20),
                    InkWell(
                      onTap: () async {
                        customerEditFormKey.currentState?.save();
                        await CustomerService.updateCustomer(
                          widget.account?.customer?.id ?? '',
                          dobController.text,
                          fullNameController.text,
                          genderController.text,
                          _selectedImage?.path ?? '',
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: ColorHelper.getColor(ColorHelper.green),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Text(
                          'Save',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}