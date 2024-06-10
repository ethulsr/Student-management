class StudentModel {
  int? id;
  final String name;
  final String age;
  final String cls;
  final String address;
  final String img;
  final String imagePath;

  StudentModel({
    required this.name,
    required this.age,
    required this.cls,
    required this.address,
    required this.img,
    required this.imagePath,
    this.id,
  });

  factory StudentModel.fromMap(Map<String, dynamic> map) {
    return StudentModel(
      id: map['id'],
      name: map['name'],
      age: map['age'],
      cls: map['class'],
      address: map['address'],
      img: map['img'] ?? 'nothing',
      imagePath:
          map['imagePath'] ?? '', // Ensure to retrieve imagePath from the map
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'age': age,
      'class': cls,
      'address': address,
      'img': img,
      'imagePath': imagePath, // Include imagePath in the map
    };
  }
}
