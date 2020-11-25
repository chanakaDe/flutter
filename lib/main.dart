import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crud_app/ui/create_new_student_screen.dart';
import 'package:flutter_crud_app/ui/student_list_screen.dart';

GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.blueAccent,
        accentColor: Colors.deepOrange,
      ),
      home: Scaffold(
        backgroundColor: Colors.white,
        key: _scaffoldState,
        appBar: AppBar(
          title: Center(
            child: Text("Cool Flutter App",
                style: TextStyle(
                  color: Colors.white,
                )),
          ),
          actions: <Widget>[
            GestureDetector(
              onTap: () async{
                var result = await Navigator.push(
                  _scaffoldState.currentContext,
                  MaterialPageRoute(builder: (BuildContext context){
                    return CreateNewStudentScreen();
                  })
                );
                if(result != null){
                  setState(() {});
                }
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 50.0),
                child: Icon(
                  Icons.person_add,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
        body: StudentListScreen(),
      ),
    );
  }
}
