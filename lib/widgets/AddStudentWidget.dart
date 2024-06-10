import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_managment/controller/student_controller.dart';

class AddStudentWidget extends StatefulWidget {
  AddStudentWidget({Key? key}) : super(key: key);

  @override
  _AddStudentWidgetState createState() => _AddStudentWidgetState();
}

class _AddStudentWidgetState extends State<AddStudentWidget> {
  final picker = ImagePicker();
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _classController = TextEditingController();
  final _addressController = TextEditingController();
  final StudentController studentController = Get.find();

  String? imagePath;

  Future<void> takePhoto() async {
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        imagePath = pickedFile.path;
      });
    }
  }

  bool _validateName(String name) {
    RegExp nameRegex = RegExp(r'^[a-zA-Z\s]+$');
    return nameRegex.hasMatch(name);
  }

  bool _validateAge(String age) {
    try {
      int ageValue = int.parse(age);
      return ageValue > 0;
    } catch (e) {
      return false;
    }
  }

  bool _validateClass(String className) {
    try {
      int ageValue = int.parse(className);
      return ageValue > 0;
    } catch (e) {
      return false;
    }
  }

  bool _validateAddress(String address) {
    return address.isNotEmpty;
  }

  void _showErrorSnackBar(BuildContext context, String message) {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    scaffoldMessenger.showSnackBar(
      SnackBar(
        content: Row(
          children: [Icon(Icons.error), Text(message)],
        ),
        backgroundColor: Colors.red,
      ),
    );
  }

  bool _validateForm(BuildContext context) {
    if (_nameController.text.isEmpty &&
        _ageController.text.isEmpty &&
        _classController.text.isEmpty &&
        _addressController.text.isEmpty &&
        imagePath == null) {
      _showErrorSnackBar(context, "All fields are empty");
      return false;
    }

    if (!_validateName(_nameController.text)) {
      _showErrorSnackBar(context, "Name field is empty or Invalid name format");
      return false;
    }

    if (!_validateAge(_ageController.text)) {
      _showErrorSnackBar(context, "Age field is empty or Invalid age format");
      return false;
    }

    if (!_validateClass(_classController.text)) {
      _showErrorSnackBar(
          context, "Class field is empty or Invalid Class format");
      return false;
    }

    if (!_validateAddress(_addressController.text)) {
      _showErrorSnackBar(
          context, "Address field is empty or Invalid Address format");
      return false;
    }

    if (imagePath == null) {
      _showErrorSnackBar(context, "Please select an image");
      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ADD STUDENT'),
        centerTitle: true,
      ),
      body: Material(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile picture section
                Text(
                  'Profile Picture',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Stack(
                  children: [
                    CircleAvatar(
                      maxRadius: 55,
                      backgroundImage: imagePath == null
                          ? const NetworkImage(
                                  'https://www.pngall.com/wp-content/uploads/5/User-Profile-PNG-Image.png')
                              as ImageProvider
                          : FileImage(File(imagePath.toString())),
                    ),
                    Positioned(
                      child: IconButton(
                        onPressed: takePhoto,
                        icon: Icon(Icons.add_a_photo),
                      ),
                      bottom: -10,
                      left: 60,
                    ),
                  ],
                ),
                SizedBox(height: 10),
                // Name field
                Text(
                  'Name',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter your Name",
                    hintStyle: TextStyle(
                        color: Colors.grey, fontStyle: FontStyle.italic),
                    labelStyle: TextStyle(color: Colors.blue),
                  ),
                ),
                SizedBox(height: 10),
                // Age field
                Text(
                  'Age',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  controller: _ageController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter your Age",
                    hintStyle: TextStyle(
                        color: Colors.grey, fontStyle: FontStyle.italic),
                    labelStyle: TextStyle(color: Colors.blue),
                  ),
                ),
                SizedBox(height: 10),
                // Class field
                Text(
                  'Class',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  controller: _classController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter your Class",
                    hintStyle: TextStyle(
                        color: Colors.grey, fontStyle: FontStyle.italic),
                    labelStyle: TextStyle(color: Colors.blue),
                  ),
                ),
                SizedBox(height: 10),
                // Address field
                Text(
                  'Address',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  controller: _addressController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter your Address",
                    hintStyle: TextStyle(
                        color: Colors.grey, fontStyle: FontStyle.italic),
                    labelStyle: TextStyle(color: Colors.blue),
                  ),
                ),
                SizedBox(height: 20),
                // Add Student Button
                ElevatedButton(
                  onPressed: () {
                    if (_validateForm(context)) {
                      studentController.addStudent(
                        _nameController.text,
                        _ageController.text,
                        _classController.text,
                        _addressController.text,
                        imagePath!,
                      );
                      _clearFields();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Student Added Successfully'),
                          backgroundColor: Colors.green,
                        ),
                      );
                    }
                  },
                  child: Text('Add Student'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _clearFields() {
    _nameController.clear();
    _ageController.clear();
    _classController.clear();
    _addressController.clear();
    setState(() {
      imagePath = null;
    });
  }
}
