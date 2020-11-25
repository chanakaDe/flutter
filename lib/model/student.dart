import 'dart:convert';

class Student {
  int id;
  String name;
  String email;
  int age;

  //constructor
  Student({this.id, this.name, this.email, this.age});

  //named constructor
  //convert map to student class
  factory Student.fromJson(Map<String, dynamic> map) {
    return Student(
        id: map["id"], name: map["name"], email: map["email"], age: map["age"]);
  }

  //convert student class to Json
  Map<String, dynamic> toJson() {
    return {"id": id, "name": name, "email": email, "age": age};
  }

  //convert student class to Json omitting id
  Map<String, dynamic> toJsonWithoutId() {
    return {"name": name, "email": email, "age": age};
  }
} //end of class

//method to deserialize json
List<Student> studentFromJson(String jsonObject) {
  //converted to a json object
  //deserialize
  final data = json.decode(jsonObject);

  return List<Student>.from(data.map((item) => Student.fromJson(item)));
}

//method to serialize json
String studentToJson(Student student) {
  final data = student.toJson();

  //serialize
  return json.encode(data);
}

//method to serialize json student without id
String studentToJsonWithoutId(Student student) {
  final data = student.toJsonWithoutId();

  //serialize
  return json.encode(data);
}
