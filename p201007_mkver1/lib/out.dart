import 'dart:io';
import 'main.dart';
import 'package:flutter/material.dart';
import "cameraout.dart";

class Out extends StatefulWidget {
  static File p1;
  @override
  _OutState createState() => _OutState();
}

class outInfo {
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
}

class _OutState extends State<Out> {
  File p1 = Out.p1;
  File p2, p3, p4, p5;
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
                  Stack(
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
                              outInfo.x.length == 0 ? Text("") : ArcWidget()),
                    ],
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
                      Text(
                        outInfo.t1,
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
                      Text(
                        outInfo.t2,
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
                      Text(
                        outInfo.t3,
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
                      Text(
                        outInfo.t4,
                      ),
                    ],
                  )
                ],
              ),
              // ),
              // inInfo.r1 == null
              //     ? Text('')
              //     : inInfo.r1['third'].length == 0
              //         ? Text('Front: Clear')
              //         : Text("Front: " +
              //             inInfo.r1['third'].length.toString() +
              //             " Defect(s)"),
              // inInfo.r2 == null
              //     ? Text('')
              //     : inInfo.r2['third'].length == 0
              //         ? Text('Right Side: Clear')
              //         : Text("Right Side: " +
              //             inInfo.r2['third'].length.toString() +
              //             " Defect(s)"),
              // inInfo.r3 == null
              //     ? Text('')
              //     : inInfo.r3['third'].length == 0
              //         ? Text('Back: Clear')
              //         : Text("Back: " +
              //             inInfo.r3['third'].length.toString() +
              //             " Defect(s)"),
              // inInfo.r4 == null
              //     ? Text('Left Side: Clear')
              //     : inInfo.r4['third'].length == 0
              //         ? Text('')
              //         : Text("Left Side: " +
              //             inInfo.r4['third'].length.toString() +
              //             " Defect(s)"),
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
                      outInfo.car_number,
                      textAlign: TextAlign.center,
                    )
                  ]),
                  TableRow(children: [
                    Text(
                      "차종",
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      outInfo.car_kind,
                      textAlign: TextAlign.center,
                    )
                  ]),
                  TableRow(children: [
                    Text(
                      "고객명",
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      outInfo.consumer_name,
                      textAlign: TextAlign.center,
                    )
                  ]),
                  TableRow(children: [
                    Text(
                      "주행거리",
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      outInfo.drived_distance,
                      textAlign: TextAlign.center,
                    )
                  ]),
                  TableRow(children: [
                    Text(
                      "유류량",
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      outInfo.fuel,
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
    for (int i = 0; i < outInfo.x.length; i++) {
      re.add(new Rect.fromLTWH(outInfo.x[i], outInfo.y[i], 3, 3));
      canvas
        ..drawRect(
            re[i],
            Paint()
              ..color = Colors.redAccent
              ..style = PaintingStyle.stroke
              ..strokeWidth = 3);
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
