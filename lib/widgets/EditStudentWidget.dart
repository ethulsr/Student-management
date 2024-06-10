import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_managment/controller/student_controller.dart';
import 'package:student_managment/model/StudentModel.dart';

class EditStudentForm extends StatefulWidget {
  final StudentModel data;

  EditStudentForm({required this.data});

  @override
  _EditStudentFormState createState() => _EditStudentFormState();
}

class _EditStudentFormState extends State<EditStudentForm> {
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _classController = TextEditingController();
  final _addressController = TextEditingController();
  final StudentController studentController = Get.find();
  final picker = ImagePicker();
  String? imagePath;

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.data.name;
    _ageController.text = widget.data.age;
    _classController.text = widget.data.cls;
    _addressController.text = widget.data.address;
    imagePath = widget.data.imagePath;
  }

  Future<void> takePhoto() async {
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        imagePath = pickedFile.path;
      });
    }
  }

  void updateStudent() {
    final name = _nameController.text;
    final age = _ageController.text;
    final cls = _classController.text;
    final address = _addressController.text;

    if (name.isNotEmpty &&
        age.isNotEmpty &&
        cls.isNotEmpty &&
        address.isNotEmpty) {
      studentController.updateStudent(
        widget.data.id!,
        name,
        age,
        cls,
        address,
        widget.data.img,
        imagePath ?? '',
      );
      Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill all fields')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          GestureDetector(
            onTap: takePhoto,
            child: CircleAvatar(
              radius: 50,
              backgroundImage: imagePath != null
                  ? FileImage(File(imagePath!))
                  : const NetworkImage(
                      'https://www.pngall.com/wp-content/uploads/5/User-Profile-PNG-Image.png'),
            ),
          ),
          TextField(
            controller: _nameController,
            decoration: InputDecoration(labelText: 'Name'),
          ),
          TextField(
            controller: _ageController,
            decoration: InputDecoration(labelText: 'Age'),
          ),
          TextField(
            controller: _classController,
            decoration: InputDecoration(labelText: 'Class'),
          ),
          TextField(
            controller: _addressController,
            decoration: InputDecoration(labelText: 'Address'),
          ),
          ElevatedButton(
            onPressed: updateStudent,
            child: Text('Update Student'),
          ),
        ],
      ),
    );
  }
}
