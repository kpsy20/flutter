import 'dart:async';
import 'dart:convert';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'dataset.dart';
import 'package:http/http.dart' as http;
import 'mainpage.dart';

Future<void> main() async {
  //카메라 찾는부분, 정확히 어떤 기능을 수행하는지는 모름..
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
      debugShowCheckedModeBanner: false,
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
  //회사코드, id, password받는 controller
  TextEditingController controller = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  TextEditingController controller3 = TextEditingController();
  String url = 'http://ai.nextlab.co.kr:8080';
  bool val = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Builder(
          builder: (context) {
            //GestureDetector -> id나 password입력하다가 화면 다른부분 누르면 입력창 내려가게 함.
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
                              textField('회사코드를 입력하세요', controller3, false),
                              textField("아이디를 입력하세요", controller, false),
                              textField("비밀번호를 입력하세요", controller2, true),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Row(
                      //로그인 유지 checkbox인데 아직 기능은 따로 없고 보여주기만..
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
                    //Login 하면 이제 다음 화면인 mainpage로 넘어감.
                    ButtonTheme(
                      minWidth: 350,
                      height: 50,
                      child: RaisedButton(
                        color: Colors.teal,
                        child: Icon(Icons.assignment_ind,
                            color: Colors.white, size: 35),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                        // padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
                        onPressed: () async {
                          MemberData.id = controller.text;
                          Map<String, dynamic> param = {};
                          param["companyid"] = int.parse(controller3.text);
                          param["memberid"] = controller.text.toString();
                          param["password"] = controller2.text.toString();

                          Map<dynamic, dynamic> paramw = {
                            "companyid": 0,
                            "memberid": "nextlab",
                            "password": "nextlab1",
                          };
                          // print(jsonEncode(param));
                          final msg = jsonEncode(param);
                          Map<String, String> headers = {
                            "Content-type": "application/json"
                          };
//로그인 부분
                          // http.Response res = await http.post(url + "/login",
                          //     headers: headers, body: msg);
                          // Data.tasks = (jsonDecode(res.body));
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

TextField textField(
    String name, TextEditingController controller, bool obscure) {
  return TextField(
    autofocus: false,
    controller: controller,
    decoration: InputDecoration(
      labelText: name,
      labelStyle: TextStyle(fontSize: 15),
    ),
    obscureText: obscure,
  );
}
