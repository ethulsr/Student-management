import 'package:get/get.dart';
import 'package:student_managment/model/StudentModel.dart';
import 'package:student_managment/db/db_functions.dart';

class StudentController extends GetxController {
  var students = <StudentModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    initDB();
  }

  Future<void> initDB() async {
    await DBFunctions.openDB();
    getAllStudents();
  }

  Future<void> addStudent(String name, String age, String cls, String address,
      String imagePath) async {
    final student = StudentModel(
      name: name,
      age: age,
      cls: cls,
      address: address,
      img: '',
      imagePath: imagePath,
    );
    await DBFunctions.addStudent(student);
    await getAllStudents();
  }

  Future<void> updateStudent(int id, String name, String age, String cls,
      String address, String img, String imagePath) async {
    await DBFunctions.updateStudent(
        id, name, age, cls, address, img, imagePath);
    await getAllStudents();
  }

  Future<void> deleteStudent(int id) async {
    await DBFunctions.deleteStudent(id);
    await getAllStudents();
  }

  Future<void> getAllStudents() async {
    final allStudents = await DBFunctions.getAllStudents();
    students.value = allStudents;
  }
}
