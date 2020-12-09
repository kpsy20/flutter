import 'dart:io';
import 'dart:math';
import 'main.dart';
import 'package:flutter/material.dart';
import "camera.dart";
import "search_car.dart";
import 'material_widget.dart';
import 'dart:async';
import 'scratch.dart';

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

  static var r1;
  static var r2;
  static var r3;
  static var r4;

  static String car_number = '-';
  static String car_kind = '-';
  static String consumer_name = '-';
  static String drived_distance = '-';
  static String fuel = '-';

  static List<double> x = [];
  static List<double> y = [];
  static List<Color> color_name = [];
  static List<double> size_dot = [];
  static int index;
}

class _InState extends State<In> {
  FutureOr syncGG(dynamic value) {
    setState(() {});
  }

  double _cdx = 0;
  double _cdy = 0;

  double get cdx => this._cdx;
  double get cdy => this._cdy;

  set cdx(double newCdx) => this._cdx = newCdx;
  set cdy(double newCdy) => this._cdy = newCdy;

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
                        ).then(syncGG);
                      },
                    ),
                  ),
                ),
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
                      child: Icon(Icons.search, color: Colors.white, size: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      onPressed: () {
                        //GO CAMERA
                        Frame.in_or_out = 'in';
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => Search_car(),
                          ),
                        ).then(syncGG);
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
                  GestureDetector(
                    onTapDown: (TapDownDetails td) {
                      setState(() {
                        this.cdx = td.localPosition.dx;
                        this.cdy = td.localPosition.dy;
                        //cdx 와 cdy에 밑 container 기준으로 좌표 저장됨.
                        if (inInfo.x.length != 0) {
                          //이제 손상이 있을 때.
                          double shortest = 450;
                          int shortest_index = -1;
                          for (int i = 0; i < inInfo.x.length; i++) {
                            double scratch_x = inInfo.x[i];
                            double scratch_y = inInfo.y[i];
                            double distance = sqrt((this.cdx - scratch_x) *
                                    (this.cdx - scratch_x) +
                                (this.cdy - scratch_y) *
                                    (this.cdy - scratch_y));
                            if (shortest > distance) {
                              shortest = distance;
                              shortest_index = i;
                              inInfo.index = i;
                            }
                          }
                          if (shortest < 50) {
                            if (inInfo.size_dot[shortest_index] == 3) {
                              for (int i = 0; i < inInfo.x.length; i++) {
                                inInfo.size_dot[i] = 3;
                              }
                              inInfo.size_dot[shortest_index] = 20;
                            } else if (inInfo.size_dot[shortest_index] == 20) {
                              print(
                                  shortest_index.toString() + '번째 손상을 선택했습니다.');
                              print(shortest.toString() + "거리차");
                              //여기에 이제 처리하는 과정..
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) => Scratch(),
                                ),
                              ).then(syncGG);
                            }
                          } else {
                            print("다시 터치");
                            for (int i = 0; i < inInfo.x.length; i++) {
                              inInfo.color_name[i] = Colors.red;
                              inInfo.size_dot[i] = 3;
                            }
                          }
                        }
                      });
                    },
                    child: Stack(
                      children: [
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
                        Center(
                            child:
                                inInfo.x.length == 0 ? Text("") : ArcWidget()),
                        // Container(
                        //   width: 300,
                        //   height: 300,
                        //   child: FlatButton(
                        //     child: Text(""),
                        //     onPressed: () {
                        //       showScratch(context, inInfo.x, inInfo.y);
                        //     },
                        //   ),
                        // )
                      ],
                    ),
                  ),
                  SizedBox(width: 20),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        child: FlatButton(
                          padding: EdgeInsets.all(0),
                          onPressed: () {
                            inPic(context, inInfo.car_number, In_Pic.pic1,
                                In_Pic.pic2, In_Pic.pic3, In_Pic.pic4, 1);
                          },
                          child: In_Pic.pic1 == null
                              ? Text('')
                              : Image.file(
                                  File(In_Pic.pic1),
                                  width: 60,
                                  height: 60,
                                ),
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      Text(
                        inInfo.t1,
                      ),
                      Container(
                        width: 60,
                        height: 60,
                        child: FlatButton(
                          padding: EdgeInsets.all(0),
                          onPressed: () {
                            inPic(context, inInfo.car_number, In_Pic.pic1,
                                In_Pic.pic2, In_Pic.pic3, In_Pic.pic4, 2);
                          },
                          child: In_Pic.pic2 == null
                              ? Text('')
                              : Image.file(
                                  File(In_Pic.pic2),
                                  width: 60,
                                  height: 60,
                                ),
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      Text(
                        inInfo.t2,
                      ),
                      Container(
                        width: 60,
                        height: 60,
                        child: FlatButton(
                          padding: EdgeInsets.all(0),
                          onPressed: () {
                            inPic(context, inInfo.car_number, In_Pic.pic1,
                                In_Pic.pic2, In_Pic.pic3, In_Pic.pic4, 3);
                          },
                          child: In_Pic.pic3 == null
                              ? Text('')
                              : Image.file(
                                  File(In_Pic.pic3),
                                  width: 60,
                                  height: 60,
                                ),
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      Text(
                        inInfo.t3,
                      ),
                      Container(
                        width: 60,
                        height: 60,
                        child: FlatButton(
                          padding: EdgeInsets.all(0),
                          onPressed: () {
                            inPic(context, inInfo.car_number, In_Pic.pic1,
                                In_Pic.pic2, In_Pic.pic3, In_Pic.pic4, 4);
                          },
                          child: In_Pic.pic4 == null
                              ? Text('')
                              : Image.file(
                                  File(In_Pic.pic4),
                                  width: 60,
                                  height: 60,
                                ),
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      Text(
                        inInfo.t4,
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(height: 20),
              Text('대여정보'),
              SizedBox(
                height: 5,
              ),
              Table(
                columnWidths: {
                  0: FlexColumnWidth(1),
                  1: FlexColumnWidth(3),
                },
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                border: TableBorder(
                  top: BorderSide(width: 1, color: Colors.black),
                  bottom: BorderSide(width: 1, color: Colors.black),
                  left: BorderSide(width: 1, color: Colors.black),
                  right: BorderSide(width: 1, color: Colors.black),
                  horizontalInside: BorderSide(width: 1, color: Colors.black),
                ),
                children: [
                  TableRow(children: [
                    Text(
                      "차량번호",
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      inInfo.car_number,
                      textAlign: TextAlign.center,
                    )
                  ]),
                  TableRow(children: [
                    Text(
                      "차종",
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      inInfo.car_kind,
                      textAlign: TextAlign.center,
                    )
                  ]),
                  TableRow(children: [
                    Text(
                      "고객명",
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      inInfo.consumer_name,
                      textAlign: TextAlign.center,
                    )
                  ]),
                  TableRow(children: [
                    Text(
                      "주행거리",
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      inInfo.drived_distance,
                      textAlign: TextAlign.center,
                    )
                  ]),
                  TableRow(children: [
                    Text(
                      "유류량",
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      inInfo.fuel,
                      textAlign: TextAlign.center,
                    )
                  ]),
                ],
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
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _ArcPainter extends CustomPainter {
  _ArcPainter();

  @override
  bool shouldRepaint(_ArcPainter oldDelegate) {
    return true;
  }

  @override
  void paint(Canvas canvas, size) {
    var re = <Rect>[];
    for (int i = 0; i < inInfo.x.length; i++) {
      re.add(new Rect.fromLTWH(inInfo.x[i], inInfo.y[i], 3, 3));
      canvas
        ..drawRect(
            re[i],
            Paint()
              ..color = inInfo.color_name[i]
              ..style = PaintingStyle.stroke
              ..strokeWidth = inInfo.size_dot[i]);
    }
  }
}

class ArcWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new SizedBox(
      width: 300.0,
      height: 300.0,
      child: new CustomPaint(
        painter: new _ArcPainter(),
      ),
    );
  }
}
