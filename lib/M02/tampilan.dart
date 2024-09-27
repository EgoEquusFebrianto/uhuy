import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'bio_provider.dart';

class MyBio extends StatelessWidget {
  const MyBio({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bioProvider = Provider.of<BioProvider>(context);
    print(bioProvider.scale);
    return Scaffold(
      appBar: AppBar(title: const Text("My Bio")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(color: Colors.red[200]),
                  child: bioProvider.image != null
                      ? Transform.scale(
                          scale: bioProvider.scale,
                          child: Image.file(
                            File(bioProvider.image!),
                            width: 200.0,
                            height: 200.0,
                            fit: BoxFit.fitHeight,
                          ),
                        )
                      : Container(
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 198, 198, 198),
                          ),
                          width: 200,
                          height: 200,
                          child: const Icon(
                            Icons.camera_alt,
                            color: Colors.grey,
                          ),
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      XFile? image = await ImagePicker()
                          .pickImage(source: ImageSource.gallery);
                      bioProvider.setImage(image?.path);
                    },
                    child: const Text("Take Image"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SpinBox(
                    max: 10.0,
                    min: 0.0,
                    value: bioProvider.score,
                    decimals: 1,
                    step: 0.1,
                    decoration: const InputDecoration(labelText: 'Decimals'),
                    onChanged: bioProvider.setScore,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      final DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: bioProvider.selectedDate ?? DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                      );
                      if (picked != null) {
                        bioProvider.setDate(picked);
                      }
                    },
                    child: const Text("Select Date"),
                  ),
                ),
                if (bioProvider.selectedDate != null)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Selected Date: ${bioProvider.formatDate(bioProvider.selectedDate!)}",
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                if (bioProvider.selectedDate == null)
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "No date selected",
                      style: TextStyle(fontSize: 16, color: Colors.red),
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.zoom_out),
                        onPressed: () {
                          bioProvider.setScale(bioProvider.scale > 0.1
                              ? bioProvider.scale - 0.1
                              : bioProvider.scale);
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.zoom_in),
                        onPressed: () {
                          bioProvider.setScale(bioProvider.scale + 0.1);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
