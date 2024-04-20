import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pagepals/helpers/color_helper.dart';
import 'package:pagepals/models/authen_models/account_model.dart';
import 'package:pagepals/screens/screens_reader/services_screen/create_widgets/text_form.dart';
import 'package:pagepals/services/file_storage_service.dart';
import 'package:pagepals/services/seminar_service.dart';
import 'package:unicons/unicons.dart';

class ReaderSeminarEditScreen extends StatefulWidget {
  const ReaderSeminarEditScreen({
    super.key,
    this.accountModel,
    required this.onUpdateDone,
    required this.id,
    required this.hostName,
    required this.seminarTitle,
    required this.date,
    required this.time,
    required this.description,
    required this.hostAvatarUrl,
    required this.bannerImageUrl,
    required this.activeSlot,
    required this.limitCustomer,
    required this.price,
    required this.duration,
    required this.bookTitle,
  });

  final Function() onUpdateDone;
  final AccountModel? accountModel;
  final String id;
  final String hostName;
  final String seminarTitle;
  final String date;
  final String time;
  final String description;
  final String hostAvatarUrl;
  final String bannerImageUrl;
  final int activeSlot;
  final int limitCustomer;
  final int price;
  final int duration;
  final String bookTitle;

  @override
  State<ReaderSeminarEditScreen> createState() =>
      _ReaderSeminarEditScreenState();
}

class _ReaderSeminarEditScreenState extends State<ReaderSeminarEditScreen> {
  final TextEditingController bookController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController durationController = TextEditingController();
  final TextEditingController limitCustomerController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController titleController = TextEditingController();

  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    titleController.text = widget.seminarTitle;
    bookController.text = widget.bookTitle;
    descriptionController.text = widget.description;
    durationController.text = widget.duration.toString();
    limitCustomerController.text = widget.limitCustomer.toString();
    priceController.text = widget.price.toString();
    selectedDate = DateTime.parse(widget.date);
    selectedTime = TimeOfDay(
      hour: int.parse(widget.time.split(':')[0]),
      minute: int.parse(widget.time.split(':')[1]),
    );
    bookController.text = widget.bookTitle;
  }

  void selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            brightness: Brightness.light,
            colorScheme: ColorScheme.light(
              primary: ColorHelper.getColor(ColorHelper.green),
              onPrimary: Colors.white,
            ).copyWith(background: Colors.white),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  void selectTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      initialEntryMode: TimePickerEntryMode.input,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Directionality(
            textDirection: Directionality.of(context),
            child: MediaQuery(
              data: MediaQuery.of(context).copyWith(
                alwaysUse24HourFormat: true,
              ),
              child: child!,
            ),
          ),
        );
      },
    );
    if (picked != null && picked != selectedTime)
      setState(() {
        selectedTime = picked;
      });
  }

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

  void _handleViewImage() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Image.file(
            _selectedImage!,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          surfaceTintColor: Colors.white,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          centerTitle: true,
          title: const Text(
            'Create seminar',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: SingleChildScrollView(
          controller: ScrollController(),
          physics: const BouncingScrollPhysics(),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                CustomTextFormField(
                  controller: titleController,
                  label: 'Title',
                ),
                const SizedBox(height: 20),
                CustomTextFormField(
                  label: 'Book',
                  controller: bookController,
                  readOnly: true,
                ),
                const SizedBox(height: 20),
                CustomTextFormField(
                  controller: descriptionController,
                  label: 'Description',
                  isDigit: false,
                  maxLines: 5,
                ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Upload image:',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        border: Border.all(
                          style: BorderStyle.solid,
                          color: Colors.grey,
                        ),
                      ),
                      child: ClipRect(
                        child: _selectedImage != null
                            ? InkWell(
                                onTap: _handleViewImage,
                                child: Image.file(
                                  _selectedImage!,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : Image.network(
                                widget.bannerImageUrl,
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    InkWell(
                      onTap: _handleImageSelection,
                      child: const Icon(
                        UniconsLine.plus_circle,
                        size: 30.0,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                CustomTextFormField(
                  controller: durationController,
                  label: 'duration',
                  isDigit: true,
                  suffixText: "minutes",
                ),
                const SizedBox(height: 20),
                CustomTextFormField(
                  controller: limitCustomerController,
                  label: 'Limit Spectator',
                  isDigit: true,
                ),
                const SizedBox(height: 20),
                CustomTextFormField(
                  controller: priceController,
                  label: 'price',
                  isDigit: true,
                  suffixText: "pals",
                ),
                const SizedBox(height: 20),
                InkWell(
                  onTap: selectDate,
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: ColorHelper.getColor(ColorHelper.white),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: ColorHelper.getColor(ColorHelper.grey),
                      ),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.calendar_today),
                        const SizedBox(width: 10),
                        Text(
                          "${selectedDate.toLocal()}".split(' ')[0],
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                InkWell(
                  onTap: selectTime,
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: ColorHelper.getColor(ColorHelper.white),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: ColorHelper.getColor(ColorHelper.grey),
                      ),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.access_time),
                        const SizedBox(width: 10),
                        Text(
                          "${selectedTime.format(context)}",
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: InkWell(
          onTap: () async {
            // show loading
            showDialog(
                context: context,
                builder: (context) {
                  return Center(
                    child: LoadingAnimationWidget.staggeredDotsWave(
                      color: ColorHelper.getColor(ColorHelper.green),
                      size: 60,
                    ),
                  );
                }
            );

            String id = widget.id;
            String readerId = widget.accountModel!.reader!.id!;
            int activeSlot = int.parse(limitCustomerController.text);
            String description = descriptionController.text;
            int duration = int.parse(durationController.text);
            int limitCustomer = int.parse(limitCustomerController.text);
            int price = int.parse(priceController.text);

            String date = selectedDate.toString().split(' ')[0];
            String hour = selectedTime.hour.toString().padLeft(2, '0');
            String minute = selectedTime.minute.toString().padLeft(2, '0');

            String startTime = date + ' ' + hour + ':' + minute + ':00';
            String title = titleController.text;

            String imageUrl = widget.bannerImageUrl;
            if(_selectedImage != null) {
                imageUrl = await FileStorageService.uploadImage(_selectedImage!);
            }

            bool result = await SeminarService.updateSeminar(
              id,
              readerId,
              activeSlot,
              description,
              duration,
              imageUrl,
              limitCustomer,
              price,
              startTime,
              title,
            );

            if (result) {
              Navigator.pop(context);
              Navigator.pop(context);
              widget.onUpdateDone();
            }
          },
          child: Container(
            height: 55,
            margin: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: ColorHelper.getColor(ColorHelper.green),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Center(
              child: Text(
                'Save Changes',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
