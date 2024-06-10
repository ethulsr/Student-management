import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_managment/controller/student_controller.dart';

class SearchScreen extends StatelessWidget {
  final StudentController studentController = Get.find();
  final RxString query = ''.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                query.value = value;
              },
              decoration: InputDecoration(
                hintText: 'Search...',
              ),
            ),
          ),
          Expanded(
            child: Obx(
              () {
                final filteredStudents = studentController.students
                    .where((student) => student.name
                        .toLowerCase()
                        .contains(query.value.toLowerCase()))
                    .toList();

                if (filteredStudents.isEmpty) {
                  return Center(
                    child: Text(
                      'No Student Found',
                      style: TextStyle(fontSize: 20),
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: filteredStudents.length,
                  itemBuilder: (context, index) {
                    final student = filteredStudents[index];
                    return ListTile(
                      title: Text(student.name),
                      subtitle: Text(student.cls),
                      leading: CircleAvatar(
                        backgroundImage: student.imagePath.isNotEmpty
                            ? FileImage(File(
                                student.imagePath)) // Use student's image path
                            : AssetImage(
                                'assets/placeholder_image.png'), // Use placeholder image if profile picture path is empty
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
