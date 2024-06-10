import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_managment/controller/student_controller.dart';
import 'package:student_managment/screens/SearchScreen.dart';
import 'package:student_managment/widgets/AddStudentWidget.dart';
import 'package:student_managment/widgets/ListStudentWidget.dart';

class ScreenHome extends StatelessWidget {
  final StudentController studentController = Get.put(StudentController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "STUDENT LIST",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => SearchScreen()));
            },
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Material(
          child: Column(
            children: [
              Expanded(
                child: ListStudentWidget(),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Align(
        alignment: Alignment.bottomRight,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddStudentWidget()),
            );
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
