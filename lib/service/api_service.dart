import 'package:flutter_crud_app/model/student.dart';
import 'package:http/http.dart' show Client;

class ApiService {

  // on android emulator localhost is 10.0.2.2
  final String baseUrl = 'http://10.0.2.2:8080';

  //http client  to handle http requests
  Client client = new Client();

  Future<List<Student>> getStudents() async {
    final responseFromServer = await client.get("$baseUrl/api/student");
    // status code 200 means OK
    if (responseFromServer.statusCode == 200) {
      return studentFromJson(responseFromServer.body);
    } else {
      return null;
    }
  }

  Future<bool> createStudent(Student student) async {
    final responseFromServer = await client.post(
      "$baseUrl/api/student",
      headers: {"content-type": "application/json"},
      body: studentToJsonWithoutId(student),
    );
    if (responseFromServer.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateStudent(Student student) async {
    final responseFromServer = await client.put(
        "$baseUrl/api/student/${student.id}",
        headers: {"content-type": "application/json"},
        body: studentToJson(student));
    if (responseFromServer.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deleteStudent(int id) async {
    final responseFromServer = await client.delete(
      "$baseUrl/api/student/$id",
      headers: {"content-type": "application/json"},
    );
    if (responseFromServer.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
