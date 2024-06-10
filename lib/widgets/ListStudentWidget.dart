import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_managment/controller/student_controller.dart';
import 'package:student_managment/widgets/EditStudentWidget.dart';

class ListStudentWidget extends StatelessWidget {
  ListStudentWidget({super.key});

  final StudentController studentController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        final studentList = studentController.students;
        if (studentList.isEmpty) {
          return Center(
            child: Text(
              'No Student is Available',
              style: TextStyle(fontSize: 20),
            ),
          );
        }
        return ListView.builder(
          itemCount: studentList.length,
          itemBuilder: (ctx, index) {
            final data = studentList[index];
            return Card(
              elevation: 4,
              shadowColor: Colors.black38,
              color: Colors.grey[300],
              child: ListTile(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (ctx1) {
                      return Padding(
                        padding: const EdgeInsets.all(40.0),
                        child: Column(
                          children: [
                            CloseButton(color: Colors.red),
                            Text(
                              "Name: " + data.name,
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 15),
                            Text(
                              "Age: " + data.age,
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 15),
                            Text(
                              "Class: " + data.cls,
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 15),
                            Text(
                              "Address: " + data.address,
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(ctx).pop();
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (ctx) {
                                        return Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: EditStudentForm(data: data),
                                        );
                                      },
                                    );
                                  },
                                  child: Text('Edit'),
                                ),
                                SizedBox(width: 20),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                title: Text(data.name),
                leading: CircleAvatar(
                  backgroundImage: data.imagePath.isNotEmpty
                      ? FileImage(File(data.imagePath))
                      : const NetworkImage(
                          'https://www.pngall.com/wp-content/uploads/5/User-Profile-PNG-Image.png'),
                  radius: 20,
                ),
                trailing: IconButton(
                  onPressed: () {
                    showDialog(
                      context: ctx,
                      builder: (ctx) {
                        return AlertDialog(
                          title: Text("Delete Student record"),
                          content: Text("Do you want to Delete?"),
                          actions: [
                            TextButton(
                              onPressed: () {
                                studentController.deleteStudent(data.id!);
                                Navigator.of(ctx).pop();
                              },
                              child: Text("Yes"),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(ctx).pop();
                              },
                              child: Text("No"),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  icon: Icon(
                    Icons.delete,
                    color: Colors.red[700],
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
