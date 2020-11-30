import 'dart:async';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'mainpage.dart';

// void main() => runApp(MyApp());
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  final firstCamera = cameras.first;
  Cam.cam = firstCamera;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        backgroundColor: Colors.black,
      ),
      home: MK(),
    );
  }
}

class MK extends StatefulWidget {
  @override
  _MKState createState() => _MKState();
}

class _MKState extends State<MK> {
  TextEditingController controller = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  TextEditingController controller3 = TextEditingController();

  bool val = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.teal[50],
      body: SafeArea(
        child: Builder(
          builder: (context) {
            return GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Row(children: [
                      SizedBox(
                        width: 10,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Image(
                          image: AssetImage('image/and.png'),
                          width: 50,
                          height: 50,
                        ),
                      ),
                    ]),
                    Padding(
                      padding: EdgeInsets.only(top: 50),
                    ),
                    Center(
                      child: Image(
                        image: AssetImage('image/apple.png'),
                        width: 150,
                        height: 150,
                      ),
                    ),
                    Form(
                      child: Theme(
                        data: ThemeData(
                          primaryColor: Colors.teal,
                          inputDecorationTheme: InputDecorationTheme(
                            labelStyle:
                                TextStyle(color: Colors.teal, fontSize: 10),
                          ),
                        ),
                        child: Container(
                          padding: EdgeInsets.all(30.0),
                          child: Column(
                            children: [
                              TextField(
                                autofocus: false,
                                controller: controller3,
                                decoration: InputDecoration(
                                  labelText: "회사코드를 입력하세요",
                                  labelStyle: TextStyle(fontSize: 15),
                                ),
                              ),
                              TextField(
                                autofocus: false,
                                controller: controller,
                                decoration: InputDecoration(
                                  labelText: "아이디를 입력하세요",
                                  labelStyle: TextStyle(fontSize: 15),
                                ),
                              ),
                              TextField(
                                autofocus: false,
                                controller: controller2,
                                decoration: InputDecoration(
                                  labelText: "비밀번호를 입력하세요",
                                  labelStyle: TextStyle(fontSize: 15),
                                ),
                                obscureText: true,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: val,
                          onChanged: (bool value) {
                            setState(
                              () {
                                val = value;
                              },
                            );
                          },
                        ),
                        Text("로그인 유지"),
                      ],
                    ),
                    ButtonTheme(
                      minWidth: 350,
                      height: 50,
                      child: RaisedButton(
                        color: Colors.teal,
                        child: Icon(Icons.assignment,
                            color: Colors.white, size: 35),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                        // padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
                        onPressed: () {
                          MemberData.id = controller.text;
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) => MainPage(),
                            ),
                          );
                        },
                      ),
                    ),
                  ], //Column children
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class MemberData {
  static String id = "null";
  static String com = "null";
}

class Cam {
  static var cam;
}

class Frame {
  static int frame = 0;
  static String in_or_out = '';
}

class In_Pic {
  static void Set(name, img) {
    if (name == 'pic1') {
      pic1 = img;
    } else if (name == 'pic2') {
      pic2 = img;
    } else if (name == 'pic3') {
      pic3 = img;
    } else if (name == 'pic4') {
      pic4 = img;
    }
  }

  static void Get(name) {
    if (name == 'pic1') {
      return pic1;
    } else if (name == 'pic2') {
      return pic2;
    } else if (name == 'pic3') {
      return pic3;
    } else if (name == 'pic4') {
      return pic4;
    }
  }

  static var pic1;
  static var pic2;
  static var pic3;
  static var pic4;
}

class Out_Pic {
  static void Set(name, img) {
    if (name == 'pic1') {
      pic1 = img;
    } else if (name == 'pic2') {
      pic2 = img;
    } else if (name == 'pic3') {
      pic3 = img;
    } else if (name == 'pic4') {
      pic4 = img;
    }
  }

  static void Get(name) {
    if (name == 'pic1') {
      return pic1;
    } else if (name == 'pic2') {
      return pic2;
    } else if (name == 'pic3') {
      return pic3;
    } else if (name == 'pic4') {
      return pic4;
    }
  }

  static var pic1;
  static var pic2;
  static var pic3;
  static var pic4;
}
