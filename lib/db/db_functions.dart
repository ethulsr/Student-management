import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../model/StudentModel.dart';

class DBFunctions {
  static late Database _db;

  static Future<void> openDB() async {
    try {
      _db = await openDatabase(
        join(await getDatabasesPath(), 'Student.db'),
        version: 1,
        onCreate: (db, version) async {
          await db.execute(
              'CREATE TABLE student(id INTEGER PRIMARY KEY, name TEXT, age TEXT, class TEXT, address TEXT, img TEXT, imagePath TEXT)');
        },
      );
    } catch (e) {
      print("Error opening database: $e");
    }
  }

  static Future<void> addStudent(StudentModel value) async {
    try {
      await _db.rawInsert(
          'INSERT INTO student(name, age, class, address, img, imagePath) VALUES(?,?,?,?,?,?)',
          [
            value.name,
            value.age,
            value.cls,
            value.address,
            value.img,
            value.imagePath
          ]);
    } catch (e) {
      print("Error adding student: $e");
    }
  }

  static Future<List<StudentModel>> getAllStudents() async {
    try {
      final _values = await _db.rawQuery('SELECT * FROM student');
      final List<StudentModel> students =
          _values.map((map) => StudentModel.fromMap(map)).toList();
      return students;
    } catch (e) {
      print("Error getting students: $e");
      return [];
    }
  }

  static Future<void> deleteStudent(int id) async {
    try {
      await _db.rawDelete('DELETE FROM student WHERE id = ?', [id]);
    } catch (e) {
      print("Error deleting student: $e");
    }
  }

  static Future<void> updateStudent(int id, String name, String age, String cls,
      String address, String img, String imagePath) async {
    try {
      await _db.rawUpdate(
          'UPDATE student SET name = ?, age = ?, class = ?, address = ?, img = ?, imagePath = ? WHERE id = ?',
          [name, age, cls, address, img, imagePath, id]);
    } catch (e) {
      print("Error updating student: $e");
    }
  }
}
