import 'package:flutter/material.dart';
import 'package:pagepals/helpers/color_helper.dart';
import 'package:pagepals/providers/reader_request_provider.dart';
import 'package:pagepals/screens/screens_reader/reader_request/reader_request_dropdown.dart';
import 'package:provider/provider.dart';

enum BookGenre {
  fiction,
  nonFiction,
  biography,
  selfHelp,
  romance,
  fantasy,
  other
}

class ReaderRequestStep1 extends StatefulWidget {
  final List<String>? listCountry;

  const ReaderRequestStep1({
    super.key,
    this.listCountry,
  });

  @override
  State<ReaderRequestStep1> createState() => _ReaderRequestStep1State();
}

class _ReaderRequestStep1State extends State<ReaderRequestStep1> {
  final TextEditingController _nicknameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _genreController = TextEditingController();
  String? selectedCountry;
  String? selectedGenre;

  @override
  Widget build(BuildContext context) {
    final readerProvider = context.watch<ReaderRequestProvider>();
    final readerRequestModel = readerProvider.readerRequestModel;
    setState(() {
      _descriptionController.text =
          readerRequestModel.information?.description ?? '';
      selectedGenre = readerRequestModel.information?.genres;
      _nicknameController.text = readerRequestModel.information?.nickname ?? '';
      selectedCountry = readerRequestModel.information?.countryAccent;
    });
    print('${widget.listCountry?.length}');
      print('selectedCountry: $selectedCountry');
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Basic Information:',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _nicknameController,
              decoration: InputDecoration(
                labelText: 'Nickname',
                labelStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  color: Colors.grey,
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black12, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: ColorHelper.getColor(ColorHelper.green), width: 2),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your nickname';
                }
                return null;
              },
              onFieldSubmitted: (value) {
                // Retrieve the Provider data using context.watch or context.read
                final readerRequestProvider =
                    context.read<ReaderRequestProvider>();

                // Update the Provider data
                readerRequestProvider.updateReaderRequestModelAtStep1(
                  nickname: value,
                  countryAccent: selectedCountry,
                  description: _descriptionController.text,
                  genre: selectedGenre,
                  languages: selectedCountry,
                );

                // Print the updated data
                print(readerRequestProvider.readerRequestModel.toString());
              },
              onTapOutside: (PointerDownEvent event) {
                final readerRequestProvider =
                    context.read<ReaderRequestProvider>();

                readerRequestProvider.updateReaderRequestModelAtStep1(
                  nickname: _nicknameController.text,
                  countryAccent: selectedCountry,
                  description: _descriptionController.text,
                  genre: selectedGenre,
                  languages: selectedCountry,
                );

                print(readerRequestProvider.readerRequestModel.toString());
              },
            ),
            const SizedBox(height: 20.0),
            ReaderRequestDropdown(
              title: 'Country',
              maxHeight: 350,
              value: selectedCountry,
              items: widget.listCountry ?? [],
              onValueChanged: (value) {
                setState(() {
                  selectedCountry = value;
                });
                final readerRequestProvider =
                    context.read<ReaderRequestProvider>();

                readerRequestProvider.updateReaderRequestModelAtStep1(
                  countryAccent: selectedCountry,
                  genre: selectedGenre,
                  description: _descriptionController.text,
                  languages: selectedCountry,
                  nickname: _nicknameController.text,
                );

                print(readerRequestProvider.readerRequestModel.toString());
              },
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Description',
                labelStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  color: Colors.grey,
                ),
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
              controller: _descriptionController,
              maxLines: 5,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your description';
                }
                return null;
              },
              onChanged: (_) {
                final readerRequestProvider =
                    context.read<ReaderRequestProvider>();

                readerRequestProvider.updateReaderRequestModelAtStep1(
                  description: _descriptionController.text,
                  countryAccent: selectedCountry,
                  genre: selectedGenre,
                  languages: selectedCountry,
                  nickname: _nicknameController.text,
                );

                print(readerRequestProvider.readerRequestModel.toString());
              },
              onTapOutside: (PointerDownEvent event) {
                final readerRequestProvider =
                    context.read<ReaderRequestProvider>();

                readerRequestProvider.updateReaderRequestModelAtStep1(
                  description: _descriptionController.text,
                  countryAccent: selectedCountry,
                  genre: selectedGenre,
                  languages: selectedCountry,
                  nickname: _nicknameController.text,
                );

                print(readerRequestProvider.readerRequestModel.toString());
              },
            ),
            const SizedBox(height: 16.0),
            ReaderRequestDropdown(
              title: 'Genre',
              value: selectedGenre,
              maxHeight: 200,
              items: BookGenre.values
                  .map((e) => e.toString().split('.').last)
                  .toList(),
              onValueChanged: (value) {
                setState(() {
                  selectedGenre = value;
                });
                final readerRequestProvider =
                    context.read<ReaderRequestProvider>();

                readerRequestProvider.updateReaderRequestModelAtStep1(
                  genre: selectedGenre,
                  description: _descriptionController.text,
                  countryAccent: selectedCountry,
                  languages: selectedCountry,
                  nickname: _nicknameController.text,
                );

                print(readerRequestProvider.readerRequestModel.toString());
              },
            ),
            // if (selectedGenre == 'other')
            //   Container(
            //     margin: const EdgeInsets.only(top: 16.0),
            //     child: TextFormField(
            //       controller: _genreController,
            //       decoration: const InputDecoration(
            //         labelText: 'Other',
            //         border: OutlineInputBorder(),
            //       ),
            //       validator: (value) {
            //         if (value == null || value.isEmpty) {
            //           return 'Please enter your genre';
            //         }
            //         return null;
            //       },
            //       onFieldSubmitted: (value) {
            //         setState(() {
            //           selectedGenre = _genreController.text;
            //         });
            //         final readerRequestProvider =
            //             context.read<ReaderRequestProvider>();
            //
            //         readerRequestProvider.updateReaderRequestModelAtStep1(
            //           genre: selectedGenre,
            //           description: _descriptionController.text,
            //           countryAccent: selectedCountry,
            //           languages: selectedCountry,
            //           nickname: _nicknameController.text,
            //         );
            //
            //         print(readerRequestProvider.readerRequestModel.toString());
            //       },
            //     ),
            //   ),
            const SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }
}
