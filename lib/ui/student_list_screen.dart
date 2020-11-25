
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crud_app/model/student.dart';
import 'package:flutter_crud_app/service/api_service.dart';
import 'package:flutter_crud_app/ui/edit_student_screen.dart';

class StudentListScreen extends StatefulWidget {
  @override
  _StudentListScreenState createState() => _StudentListScreenState();
}

class _StudentListScreenState extends State<StudentListScreen> {
  BuildContext context;
  ApiService apiService;

  //it is a method which is called once when the stateful widget is inserted in the widget tree.
  //it must also call super.initState()
  @override
  void initState() {
    super.initState();
    apiService = new ApiService();
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;

    //safeArea is basically a glorified Padding widget.
    // If you wrap another widget with SafeArea, it adds any necessary padding needed
    // to keep your widget from being blocked by the system status bar, notches, holes,
    // rounded corners and other "creative" features by manufactures
    return SafeArea(
      child: FutureBuilder(
          future: apiService.getStudents(),
          builder: (BuildContext context, AsyncSnapshot<List<Student>> snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text("Error Loading data ${snapshot.error.toString()}"),
              );
            }
            else if (snapshot.connectionState == ConnectionState.done) {
              List<Student> studentList = snapshot.data;
              return _buildListView(studentList);
            }
            else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }
      ),
    );
  }


  Widget _buildListView(List<Student> studentList) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 10.0),
      child: ListView.builder(
        itemBuilder: (context, index) {
          Student student = studentList[index];
          return Padding(
            padding: const EdgeInsets.only(top: 7.0),
            child: Card(
              color: Colors.grey[100],
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text("Name: "),
                        Text(
                            '${student.name}',
                            style: TextStyle(color: Colors.teal,
                                fontWeight: FontWeight.bold,
                                fontSize: 20)
                        ),
                      ],
                    ),
                    Text("Age: ${student.age.toString()}"),
                    Text("Email: ${student.email}"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        FlatButton(
                          onPressed: () {
                            //showDialog() is used method to display the Alert dialog.
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text("Warning"),
                                    content: Text("Are you sure to delete the student ${student.name}?"),
                                    actions: <Widget>[
                                      FlatButton(
                                        child: Text("Yes"),
                                        onPressed: () {
                                          Navigator.pop(context);
                                          apiService.deleteStudent(student.id).then((isSuccess){
                                            if(isSuccess){
                                              setState((){});
                                              Scaffold.of(this.context).showSnackBar(SnackBar(content: Text("Student Deleted Successfully")));
                                            }
                                            else{
                                              Scaffold.of(this.context).showSnackBar(SnackBar(content: Text("Could not delete the student")));
                                            }
                                          });
                                        },
                                      ),
                                      FlatButton(
                                        child: Text("No"),
                                        onPressed: (){
                                            Navigator.pop(context);
                                        },
                                      )
                                    ],
                                  );
                                });
                          },
                          child: Text("Delete", style: TextStyle(color: Colors.red),),
                        ),
                        FlatButton(
                          onPressed: () async{
                            var result = await Navigator.push(
                              context, MaterialPageRoute(builder: (context){
                                return EditStudentScreen(student);
                            }
                            )
                            );
                            if(result != null){
                              setState(() {});
                            }
                            },
                          child: Text("Edit", style: TextStyle(color: Colors.green),),
                        )
                      ],
                    )

                  ],
                ),
              ),
            ),
          );
        },
        itemCount: studentList.length,
      ),
    );
  }

}