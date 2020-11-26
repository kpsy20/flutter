import 'dart:io';
import 'main.dart';
import 'package:flutter/material.dart';
import "camera.dart";
import 'package:flutter/services.dart';
import 'task.dart';

class In extends StatefulWidget {
  static File p1;
  @override
  _InState createState() => _InState();
}

class inInfo {
  static String t1 = "not yet";
  static String t2 = "not yet";
  static String t3 = "not yet";
  static String t4 = "not yet";
}

class _InState extends State<In> {
  File p1 = In.p1;
  File p2, p3, p4, p5;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '입고등록',
        ),
        backgroundColor: Colors.teal,
      ),
      body: SafeArea(
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
                  child: ButtonTheme(
                    minWidth: 50,
                    height: 50,
                    child: RaisedButton(
                      color: Colors.teal,
                      child:
                          Icon(Icons.camera_alt, color: Colors.white, size: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      onPressed: () {
                        //GO CAMERA
                        Frame.in_or_out = 'in';
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => Camera4(),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ]),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: 300,
                    height: 300,
                    decoration: BoxDecoration(
                      //여기에 이제 띄워야함. 파손된 부위들을.
                      border: Border.all(color: Colors.black, width: 1),
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: AssetImage('image/defect.jpg'),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        child: In_Pic.pic1 == null
                            ? Text('')
                            : Image.file(
                                File(In_Pic.pic1),
                                width: 60,
                                height: 60,
                              ),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1),
                          borderRadius: BorderRadius.circular(5),
                          // image: DecorationImage(
                          //   image: AssetImage('image/1.png'),
                          // ),
                        ),
                      ),
                      Text(
                        inInfo.t1,
                      ),
                      Container(
                        width: 60,
                        height: 60,
                        child: In_Pic.pic2 == null
                            ? Text('')
                            : Image.file(
                                File(In_Pic.pic2),
                                width: 60,
                                height: 60,
                              ),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1),
                          borderRadius: BorderRadius.circular(5),
                          // image: DecorationImage(
                          //   image: AssetImage('image/2.png'),
                          // ),
                        ),
                      ),
                      Text(
                        inInfo.t2,
                      ),
                      Container(
                        width: 60,
                        height: 60,
                        child: In_Pic.pic3 == null
                            ? Text('')
                            : Image.file(
                                File(In_Pic.pic3),
                                width: 60,
                                height: 60,
                              ),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1),
                          borderRadius: BorderRadius.circular(5),
                          // image: DecorationImage(
                          //   image: AssetImage('image/3.png'),
                          // ),
                        ),
                      ),
                      Text(
                        inInfo.t3,
                      ),
                      Container(
                        width: 60,
                        height: 60,
                        child: In_Pic.pic4 == null
                            ? Text('')
                            : Image.file(
                                File(In_Pic.pic4),
                                width: 60,
                                height: 60,
                              ),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1),
                          borderRadius: BorderRadius.circular(5),
                          // image: DecorationImage(
                          //   image: AssetImage('image/4.png'),
                          // ),
                        ),
                      ),
                      Text(
                        inInfo.t4,
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: 400,
                height: 200,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 2),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 5,
                    ),
                    Text('대여정보'),
                    SizedBox(
                      height: 5,
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(5, 3, 5, 3),
                            ),
                            Container(
                              width: 90,
                              height: 30,
                              child: Text(
                                '차량번호',
                                textAlign: TextAlign.center,
                              ),
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.blue, width: 1.5),
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            SizedBox(
                              width: 1,
                            ),
                            Container(
                              width: 280,
                              height: 30,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.teal, width: 1.5),
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(5, 3, 5, 3),
                            ),
                            Container(
                              width: 90,
                              height: 30,
                              child: Text(
                                '차종',
                                textAlign: TextAlign.center,
                              ),
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.blue, width: 1.5),
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            SizedBox(
                              width: 1,
                            ),
                            Container(
                              width: 280,
                              height: 30,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.teal, width: 1.5),
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(5, 3, 5, 3),
                            ),
                            Container(
                              width: 90,
                              height: 30,
                              child: Text(
                                '고객명',
                                textAlign: TextAlign.center,
                              ),
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.blue, width: 1.5),
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            SizedBox(
                              width: 1,
                            ),
                            Container(
                              width: 280,
                              height: 30,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.teal, width: 1.5),
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(5, 3, 5, 3),
                            ),
                            Container(
                              width: 90,
                              height: 30,
                              child: Text(
                                '주행거리',
                                textAlign: TextAlign.center,
                              ),
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.blue, width: 1.5),
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            SizedBox(
                              width: 1,
                            ),
                            Container(
                              width: 280,
                              height: 30,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.teal, width: 1.5),
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(5, 3, 5, 3),
                            ),
                            Container(
                              width: 90,
                              height: 30,
                              child: Text(
                                '유류량',
                                textAlign: TextAlign.center,
                              ),
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.blue, width: 1.5),
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            SizedBox(
                              width: 1,
                            ),
                            Container(
                              width: 280,
                              height: 30,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.teal, width: 1.5),
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: 400,
                height: 100,
                child: Text(
                  '정산금액',
                  textAlign: TextAlign.center,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 2),
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ButtonTheme(
                    minWidth: 190,
                    height: 30,
                    child: RaisedButton(
                      color: Colors.teal,
                      child: Text(
                        '정비필요',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      // padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
                      onPressed: () {},
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  ButtonTheme(
                    minWidth: 190,
                    height: 30,
                    child: RaisedButton(
                      color: Colors.teal,
                      child: Text(
                        '현장입고',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      // padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
                      onPressed: () {},
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
