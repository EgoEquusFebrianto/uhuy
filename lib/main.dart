import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Bio App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyBio(),
    );
  }
}

class MyBio extends StatefulWidget {
  const MyBio({Key? key}) : super(key: key);

  @override
  State<MyBio> createState() => _MyBioState();
}

class _MyBioState extends State<MyBio> {
  String? _image;
  double _score = 0;
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Bio")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(color: Colors.red[200]),
              child: _image != null
                  ? Image.file(
                File(_image!),
                width: 200.0,
                height: 200.0,
                fit: BoxFit.fitHeight,
              )
                  : Container(
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 198, 198, 198),
                ),
                width: 200,
                height: 200,
                child: Icon(
                  Icons.camera_alt,
                  color: Colors.grey[800],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () async {
                  XFile? image = await _picker.pickImage(source: ImageSource.gallery);
                  setState(() {
                    if (image != null) {
                      _image = image.path;
                    }
                  });
                },
                child: const Text("Take Image"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SpinBox(
                max: 10.0,
                min: 0.0,
                value: _score,
                decimals: 1,
                step: 0.1,
                decoration: const InputDecoration(labelText: 'Score'),
                onChanged: (value) {
                  setState(() {
                    _score = value;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
