import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pagepals/models/google_book.dart';
import 'package:pagepals/screens/screens_reader/services_screen/create_widgets/search_book_screen.dart';
import 'package:pagepals/screens/screens_reader/services_screen/create_widgets/service_type_dropdown.dart';
import 'package:pagepals/screens/screens_reader/services_screen/create_widgets/text_form.dart';
import 'package:pagepals/services/service_service.dart';
import 'package:quickalert/quickalert.dart';

class CreateService extends StatefulWidget {
  final String readerId;
  final Function(bool?)? onCreated;

  const CreateService({super.key, required this.readerId, this.onCreated});

  @override
  State<CreateService> createState() => _CreateServiceState();
}

class _CreateServiceState extends State<CreateService> {
  String? selectedServiceType;

  GoogleBookModel? selectedGoogleBook;

  final TextEditingController serviceNameController = TextEditingController();

  final TextEditingController priceController = TextEditingController();
  final TextEditingController bookController = TextEditingController();

  void handleSelectedBook(value) {
    print('selectedGGBook : ${value.toString()}');
    GoogleBookModel book = value;
    setState(() {
      selectedGoogleBook = book;
      bookController.text = book.volumeInfo!.title!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Service'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            widget.onCreated!(true);
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        controller: ScrollController(),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              CustomTextFormField(
                label: 'Book',
                controller: bookController,
                readOnly: true,
                onTap: () {
                  Navigator.of(context).push(PageTransition(
                    child: SearchBookScreen(onTap: handleSelectedBook),
                    type: PageTransitionType.fade,
                    duration: const Duration(milliseconds: 300),
                  ));
                },
              ),
              const SizedBox(height: 20),
              ServiceTypeDropdown(
                onChanged: (value) {
                  setState(() {
                    selectedServiceType = value;
                  });
                },
                value: selectedServiceType,
              ),
              const SizedBox(height: 20),
              CustomTextFormField(
                controller: serviceNameController,
                label: 'Service Name',
              ),
              const SizedBox(height: 20),
              CustomTextFormField(
                controller: priceController,
                label: 'Price',
                isDigit: true,
              ),
              const SizedBox(height: 20),
              const CustomTextFormField(
                label: 'Duration',
                initValue: '60 minutes',
                readOnly: true,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  // show loading
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return Center(
                        child: LoadingAnimationWidget.staggeredDotsWave(
                          color: Colors.greenAccent,
                          size: 60,
                        ),
                      );
                    },
                  );

                  double price = double.tryParse(priceController.text) ?? 00.00;
                  String description = serviceNameController.text;
                  // create service
                  bool created = await ServiceService.createService(
                    widget.readerId,
                    selectedServiceType!,
                    selectedGoogleBook!,
                    description,
                    price,
                    60,
                  );
                  if (created) {
                    Future.delayed(const Duration(milliseconds: 100), () {
                      Navigator.pop(context);
                      QuickAlert.show(
                        context: context,
                        type: QuickAlertType.success,
                        title: 'Service Created',
                        text: 'Service has been created successfully',
                      );
                      bookController.clear();
                      serviceNameController.clear();
                      priceController.clear();
                      setState(() {
                        selectedGoogleBook = null;
                        selectedServiceType = null;
                      });
                    });
                  } else {
                    Future.delayed(const Duration(milliseconds: 100), () {
                      Navigator.pop(context);
                      QuickAlert.show(
                        context: context,
                        type: QuickAlertType.error,
                        title: 'Create Failed',
                        text: 'Failed to create service. Please try again.',
                      );
                    });
                  }
                },
                child: const Text('Create Service'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
