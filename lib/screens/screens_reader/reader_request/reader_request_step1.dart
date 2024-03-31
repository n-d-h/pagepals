import 'package:flutter/material.dart';
import 'package:pagepals/providers/reader_request_provider.dart';
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
  ReaderRequestStep1({
    super.key,
    this.listCountry,
  });

  List<String>? listCountry = [];

  @override
  State<ReaderRequestStep1> createState() => _ReaderRequestStep1State();
}

class _ReaderRequestStep1State extends State<ReaderRequestStep1> {
  final TextEditingController _nicknameController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _genreController = TextEditingController();

  void setRegisterReaderModelValue(value) {
    setState(() {
      _descriptionController.text = value.description;
      _genreController.text = value.genre;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Padding(
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
                decoration: const InputDecoration(
                  labelText: 'Nickname',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your nickname';
                  }
                  return null;
                },
                onFieldSubmitted: (value) {
                  // Retrieve the Provider data using context.watch or context.read
                  final readerRequestProvider = context.read<ReaderRequestProvider>();

                  // Update the Provider data
                  readerRequestProvider.updateReaderRequestModelAtStep1(
                    nickname: value,
                    countryAccent: _countryController.text,
                    description: _descriptionController.text,
                    genre: _genreController.text,
                    languages: _countryController.text,
                  );

                  // Print the updated data
                  print(readerRequestProvider.readerRequestModel.toString());
                },
              ),
              const SizedBox(height: 20.0),
              DropdownMenu<String>(
                hintText: 'Country',
                width: MediaQuery.of(context).size.width * 0.92,
                label: const Text('Country'),
                requestFocusOnTap: true,
                enableFilter: true,
                enableSearch: true,
                enabled: true,
                controller: _countryController,
                menuHeight: 300.0,
                menuStyle: MenuStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                  elevation: MaterialStateProperty.all(0),
                  side: MaterialStateProperty.all(
                    const BorderSide(color: Colors.grey),
                  ),
                ),
                searchCallback: (list, data) {
                  for (int i = 0; i < list.length; i++) {
                    final entryValue = list[i].value.toString().toLowerCase();
                    if (entryValue.contains(data.toLowerCase())) {
                      return i;
                    }
                  }
                  return null;
                },
                onSelected: (String? value) {
                  final readerRequestProvider = context.read<ReaderRequestProvider>();

                  readerRequestProvider.updateReaderRequestModelAtStep1(
                    countryAccent: value,
                    genre: _genreController.text,
                    description: _descriptionController.text,
                    languages: _countryController.text,
                    nickname: _nicknameController.text,
                  );

                  print(readerRequestProvider.readerRequestModel.toString());
                },
                dropdownMenuEntries: widget.listCountry!
                    .map<DropdownMenuEntry<String>>((String value) {
                  return DropdownMenuEntry<String>(
                    value: value,
                    label: value,
                  );
                }).toList(),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
                controller: _descriptionController,
                maxLines: 5,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your description';
                  }
                  return null;
                },
                onFieldSubmitted: (value) {
                  final readerRequestProvider = context.read<ReaderRequestProvider>();

                  readerRequestProvider.updateReaderRequestModelAtStep1(
                    description: value,
                    countryAccent: _countryController.text,
                    genre: _genreController.text,
                    languages: _countryController.text,
                    nickname: _nicknameController.text,
                  );
                },
              ),
              const SizedBox(height: 16.0),
              DropdownMenu<String>(
                hintText: 'Genre',
                width: MediaQuery.of(context).size.width * 0.92,
                label: const Text('Genre'),
                requestFocusOnTap: true,
                enableFilter: true,
                enableSearch: true,
                enabled: true,
                controller: _genreController,
                menuHeight: 300.0,
                menuStyle: MenuStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                  elevation: MaterialStateProperty.all(0),
                  side: MaterialStateProperty.all(
                    const BorderSide(color: Colors.grey),
                  ),
                ),
                onSelected: (String? value) {
                  // context
                  //     .read<ReaderRequestProvider>()
                  //     .updateReaderRequestModelAtStep1(
                  //       genre: value,
                  //       description: _descriptionController.text,
                  //       countryAccent: _countryAccentController.text,
                  //       languages: _countryAccentController.text,
                  //       nickname: _nicknameController.text,
                  //     );
                  Provider.of<ReaderRequestProvider>(context, listen: false)
                      .updateReaderRequestModelAtStep1(
                    genre: value,
                    description: _descriptionController.text,
                    countryAccent: _countryController.text,
                    languages: _countryController.text,
                    nickname: _nicknameController.text,
                  );
                },
                dropdownMenuEntries: BookGenre.values
                    .map<DropdownMenuEntry<String>>((BookGenre value) {
                  return DropdownMenuEntry<String>(
                    value: value.toString().split('.').last,
                    label: value.toString().split('.').last,
                  );
                }).toList(),
              ),
              if (_genreController.text == 'other')
                Container(
                  margin: const EdgeInsets.only(top: 16.0),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Other',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your genre';
                      }
                      return null;
                    },
                    onFieldSubmitted: (value) {
                      final readerRequestProvider = context.read<ReaderRequestProvider>();

                      readerRequestProvider.updateReaderRequestModelAtStep1(
                        genre: value,
                        description: _descriptionController.text,
                        countryAccent: _countryController.text,
                        languages: _countryController.text,
                        nickname: _nicknameController.text,
                      );

                      print(readerRequestProvider.readerRequestModel.toString());
                    },
                  ),
                ),
              const SizedBox(height: 16.0),
            ],
          ),
        ),
      ),
    );
  }
}
