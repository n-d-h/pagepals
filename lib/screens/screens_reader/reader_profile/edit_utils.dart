import 'package:flutter/material.dart';
import 'package:pagepals/models/reader_models/reader_profile_model.dart';

class EditUtils {
  static Future showEditBottomSheet(BuildContext context, String title,
      String initValue) {
    TextEditingController controller = TextEditingController(text: initValue);
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.7,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              padding: const EdgeInsets.all(10),
              alignment: Alignment.bottomCenter,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      labelText: title,
                      hintText: 'input $title',
                    ),
                    maxLines: title == 'Description' ? 10 : null,
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
            ),
            Positioned(
              top: 0,
              right: 2,
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
        );
      },
    );
  }

  static void showBottomSheetForUpload(BuildContext context, Function() onTap) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.3,
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
                onTap: onTap,
                child: const Text(
                  'Upload Video',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.blue,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              InkWell(
                onTap: onTap,
                child: const Text(
                  'Upload Image',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.blue,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
