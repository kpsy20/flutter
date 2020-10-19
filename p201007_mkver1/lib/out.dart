import 'dart:io';

import 'camera.dart';
import 'main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Out extends StatefulWidget {
  @override
  _OutState createState() => _OutState();
}

class _OutState extends State<Out> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '출고등록',
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
                        Frame.in_or_out = 'out';
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
                      border: Border.all(color: Colors.black, width: 1),
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: AssetImage('image/car.jpg'),
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
                        child: Out_Pic.pic1 == null
                            ? Text('')
                            : Image.file(
                                File(Out_Pic.pic1),
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
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: 60,
                        height: 60,
                        child: Out_Pic.pic2 == null
                            ? Text('')
                            : Image.file(
                                File(Out_Pic.pic2),
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
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: 60,
                        height: 60,
                        child: Out_Pic.pic3 == null
                            ? Text('')
                            : Image.file(
                                File(Out_Pic.pic3),
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
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: 60,
                        height: 60,
                        child: Out_Pic.pic4 == null
                            ? Text('')
                            : Image.file(
                                File(Out_Pic.pic4),
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
                  '고객 고지 사항 체크리스트',
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
                        '출고완료',
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
