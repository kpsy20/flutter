import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import "cameraout.dart";
import "search_car.dart";
import 'material_widget.dart';
import 'dart:async';
import 'scratch.dart';
import 'dataset.dart';

class Out extends StatefulWidget {
  @override
  _OutState createState() => _OutState();
}

class _OutState extends State<Out> {
  FutureOr syncGG(dynamic value) {
    setState(() {});
  }

  double _cdx = 0;
  double _cdy = 0;

  double get cdx => this._cdx;
  double get cdy => this._cdy;

  set cdx(double newCdx) => this._cdx = newCdx;
  set cdy(double newCdy) => this._cdy = newCdy;

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
                            builder: (BuildContext context) => Camera4O(),
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
                        Frame.in_or_out = 'out';
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
                      setState(
                        () {
                          this.cdx = td.localPosition.dx;
                          this.cdy = td.localPosition.dy;
                          //cdx 와 cdy에 밑 container 기준으로 좌표 저장됨.
                          if (outInfo.x.length != 0) {
                            //이제 손상이 있을 때.
                            double shortest = 450;
                            int shortest_index = -1;
                            for (int i = 0; i < outInfo.x.length; i++) {
                              double scratch_x = outInfo.x[i];
                              double scratch_y = outInfo.y[i];
                              double distance = sqrt((this.cdx - scratch_x) *
                                      (this.cdx - scratch_x) +
                                  (this.cdy - scratch_y) *
                                      (this.cdy - scratch_y));
                              if (shortest > distance) {
                                shortest = distance;
                                shortest_index = i;
                                outInfo.index = i;
                              }
                            }
                            if (shortest < 50) {
                              if (outInfo.size_dot[shortest_index] == 3) {
                                for (int i = 0; i < outInfo.x.length; i++) {
                                  outInfo.size_dot[i] = 3;
                                }
                                outInfo.size_dot[shortest_index] = 20;
                              } else if (outInfo.size_dot[shortest_index] ==
                                  20) {
                                print(shortest_index.toString() +
                                    '번째 손상을 선택했습니다.');
                                print(shortest.toString() + "거리차");
                                //여기에 이제 처리하는 과정..
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        Scratch(),
                                  ),
                                ).then(syncGG);
                              }
                            } else {
                              print("다시 터치");
                              for (int i = 0; i < outInfo.x.length; i++) {
                                outInfo.color_name[i] = Colors.red;
                                outInfo.size_dot[i] = 3;
                              }
                            }
                          }
                        },
                      );
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
                                outInfo.x.length == 0 ? Text("") : ArcWidget()),
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
                            outPic(context, outInfo.car_number, Out_Pic.pic1,
                                Out_Pic.pic2, Out_Pic.pic3, Out_Pic.pic4, 1);
                          },
                          child: Out_Pic.pic1 == null
                              ? Text('')
                              : Image.file(
                                  File(Out_Pic.pic1),
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
                        outInfo.t1,
                      ),
                      Container(
                        width: 60,
                        height: 60,
                        child: FlatButton(
                          padding: EdgeInsets.all(0),
                          onPressed: () {
                            outPic(context, outInfo.car_number, Out_Pic.pic1,
                                Out_Pic.pic2, Out_Pic.pic3, Out_Pic.pic4, 2);
                          },
                          child: Out_Pic.pic2 == null
                              ? Text('')
                              : Image.file(
                                  File(Out_Pic.pic2),
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
                        outInfo.t2,
                      ),
                      Container(
                        width: 60,
                        height: 60,
                        child: FlatButton(
                          padding: EdgeInsets.all(0),
                          onPressed: () {
                            outPic(context, outInfo.car_number, Out_Pic.pic1,
                                Out_Pic.pic2, Out_Pic.pic3, Out_Pic.pic4, 3);
                          },
                          child: Out_Pic.pic3 == null
                              ? Text('')
                              : Image.file(
                                  File(Out_Pic.pic3),
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
                        outInfo.t3,
                      ),
                      Container(
                        width: 60,
                        height: 60,
                        child: FlatButton(
                          padding: EdgeInsets.all(0),
                          onPressed: () {
                            outPic(context, outInfo.car_number, Out_Pic.pic1,
                                Out_Pic.pic2, Out_Pic.pic3, Out_Pic.pic4, 4);
                          },
                          child: Out_Pic.pic4 == null
                              ? Text('')
                              : Image.file(
                                  File(Out_Pic.pic4),
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
                        outInfo.t4,
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
              ..color = outInfo.color_name[i]
              ..style = PaintingStyle.stroke
              ..strokeWidth = outInfo.size_dot[i]);
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
