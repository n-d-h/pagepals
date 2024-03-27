import 'package:flutter/material.dart';

class ReaderEditProfileScreen extends StatefulWidget {
  const ReaderEditProfileScreen({super.key});

  @override
  State<ReaderEditProfileScreen> createState() =>
      _ReaderEditProfileScreenState();
}

class _ReaderEditProfileScreenState extends State<ReaderEditProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        centerTitle: true,
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
                  Stack(
                    children: [
                      const CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage('assets/image_reader.png'),
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
                          child: IconButton(
                            icon: const Icon(
                              Icons.camera_alt,
                              size: 20,
                            ),
                            onPressed: () {},
                          ),
                        ),
                      ),
                    ],
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildDataField('Full Name', 'John Doe', () {
                    showBottomSheet(
                      context,
                      initialValue: 'John Doe',
                      title: 'Full Name',
                    ).then(
                      (value) => {
                        if (value != null) {print(value)}
                      },
                    );
                  }),
                  buildDataField('Email', 'john@gmail.com', () {
                    showBottomSheet(
                      context,
                      initialValue: 'Email',
                      title: 'Email',
                    ).then(
                      (value) => {
                        if (value != null) {print(value)}
                      },
                    );
                  }),
                  buildDataField('Phone Number', '08012345678', () {
                    showBottomSheet(
                      context,
                      initialValue: '08012345678',
                      title: 'Phone Number',
                    ).then(
                      (value) => {
                        if (value != null) {print(value)}
                      },
                    );
                  }),
                  buildDataField('Date of Birth', '12/12/1990', () {
                    showBottomSheet(
                      context,
                      initialValue: '12/12/1990',
                      title: 'Date of Birth',
                    ).then(
                      (value) => {
                        if (value != null) {print(value)}
                      },
                    );
                  }),
                  buildDataField('Location', 'Lagos', () {
                    showBottomSheet(
                      context,
                      initialValue: 'Lagos',
                      title: 'Location',
                    ).then(
                      (value) => {
                        if (value != null) {print(value)}
                      },
                    );
                  }),
                  buildDataField('Language', 'English', () {
                    showBottomSheet(
                      context,
                      initialValue: 'English',
                      title: 'Language',
                    ).then(
                      (value) => {
                        if (value != null) {print(value)}
                      },
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDataField(
    String title,
    String value,
    Function() onTap,
  ) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w500,
            ),
          ),
          InkWell(
            borderRadius: BorderRadius.circular(10),
            radius: 10,
            splashColor: Colors.white,
            onTap: onTap,
            child: Row(
              children: [
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w200,
                  ),
                ),
                const SizedBox(width: 10),
                const Icon(Icons.arrow_forward_ios),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future showBottomSheet(BuildContext context,
      {String? initialValue, String? title}) {
    TextEditingController controller =
        TextEditingController(text: initialValue);

    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.8,
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      labelText: title ?? 'Full Name',
                      hintText: 'John Doe',
                    ),
                  ),
                  const Text(
                    'This information will be visible to other users',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context, {
                          'value': controller.text,
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Text(
                          'Save',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                top: 0,
                right: 0,
                child: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    Navigator.pop(context, {
                      'value': controller.text,
                    });
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
