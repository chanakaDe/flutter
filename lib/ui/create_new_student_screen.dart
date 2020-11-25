import 'package:flutter/material.dart';
import 'package:flutter_crud_app/model/student.dart';
import 'package:flutter_crud_app/service/api_service.dart';

final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

class CreateNewStudentScreen extends StatefulWidget {
  @override
  _CreateNewStudentScreenState createState() => _CreateNewStudentScreenState();
}

class _CreateNewStudentScreenState extends State<CreateNewStudentScreen> {
  bool _isLoading = false;
  ApiService _apiService = ApiService();

  TextEditingController _controllerForName = TextEditingController();
  TextEditingController _controllerForAge = TextEditingController();
  TextEditingController _controllerForEmail = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        key: _scaffoldState,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.indigo),
          title: Text(
            "Save Student Information",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        body: Stack(
          children: [
            Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    _buildTextFieldForName(),
                    _buildTextFielForAge(),
                    _buildTextFieldForEmail(),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: RaisedButton(
                        child: Text(
                          "Submit",
                          style: TextStyle(color: Colors.white),
                        ),
                      onPressed: (){
                        setState(() =>_isLoading = true);
                        String name =_controllerForName.text.toString();
                        String email =_controllerForEmail.text.toString();
                        int age  = int.parse(_controllerForAge.text.toString());
                        // converitng to json object
                        Student student = Student(name: name, age: age, email: email);
                        _apiService.createStudent(student).then((isSuccess){
                          setState(() => _isLoading = false);
                          if(isSuccess){
                            Navigator.pop(_scaffoldState.currentState.context, true);
                          }
                          else{
                            _scaffoldState.currentState.showSnackBar(SnackBar(
                              content: Text("Submit data failed"),
                            ));
                          }
                        });
                      },
                      color: Colors.indigo,
                      )
                    )
                  ],
                )
            ),
            _isLoading
                ? Stack(
              children: <Widget>[
                Opacity(
                  opacity: 0.3,
                  child: ModalBarrier(
                    dismissible: false,
                    color: Colors.grey,
                  ),
                ),
                Center(
                  child: CircularProgressIndicator(),
                ),
              ],
            )
                : Container(),
          ],
        )
    );
  }

  Widget _buildTextFieldForName() {
    return TextField(
      controller: _controllerForName,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Full Name",
      ),
    );
  }

  Widget _buildTextFielForAge() {
    return TextField(
      controller: _controllerForAge,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: "Age",
      ),
    );
  }

 Widget _buildTextFieldForEmail() {
    return TextField(
      controller: _controllerForEmail,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: "Email Address",
      )
    );
 }
}
