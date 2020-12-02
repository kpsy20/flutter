import 'package:flutter/material.dart';
import 'in.dart';
import 'out.dart';
import 'main.dart';

class Search_car extends StatefulWidget {
  @override
  _Search_carState createState() => _Search_carState();
}

class _Search_carState extends State<Search_car> {
  @override
  TextEditingController controller = TextEditingController();
  String car_number = '';
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("차량 검색"),
        backgroundColor: Colors.teal,
      ),
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
                                controller: controller,
                                decoration: InputDecoration(
                                  labelText: "차량 번호를 입력하세요",
                                  labelStyle: TextStyle(fontSize: 15),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ButtonTheme(
                          minWidth: 100,
                          height: 50,
                          child: RaisedButton(
                            color: Colors.teal,
                            child: Text("확인",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white)),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                            // padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
                            onPressed: () {
                              return showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text(controller.text),
                                    content: Text('2020 / K5'),
                                    actions: [
                                      FlatButton(
                                        child: Text('확인'),
                                        onPressed: () {
                                          if (Frame.in_or_out == 'in') {
                                            inInfo.car_number = controller.text;
                                          } else {
                                            outInfo.car_number =
                                                controller.text;
                                          }
                                          Navigator.of(context).pop();
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      FlatButton(
                                        child: Text("취소"),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      )
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        ),
                        SizedBox(width: 20),
                        ButtonTheme(
                          minWidth: 100,
                          height: 50,
                          child: RaisedButton(
                            color: Colors.red,
                            child: Text("취소",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white)),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                            // padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ],
                    )
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
