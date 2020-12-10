import 'dart:async';
import 'package:flutter/material.dart';
import 'in.dart';
import 'out.dart';
import 'task.dart';
import 'dataset.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  FutureOr syncGG(dynamic value) {
    setState(() {});
  }

  @override
  var now = new DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
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
              Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(MemberData.id),
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      now.year.toString() +
                          "/" +
                          now.month.toString() +
                          "/" +
                          now.day.toString() +
                          " " +
                          now.hour.toString() +
                          ":" +
                          now.minute.toString(),
                    ),
                  ),
                ],
              ),
              Padding(padding: EdgeInsets.only(top: 25)),
              ButtonTheme(
                minWidth: 350,
                height: 150,
                child: RaisedButton(
                  color: Colors.teal,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.camera_rear, color: Colors.white, size: 35),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        '입고등록',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      )
                    ],
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  // padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
                  onPressed: () {
                    // print(Data.tasks);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => In(),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ButtonTheme(
                minWidth: 350,
                height: 150,
                child: RaisedButton(
                  color: Colors.teal,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.center_focus_weak,
                          color: Colors.white, size: 35),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        '출고등록',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      )
                    ],
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  // padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => Out(),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ButtonTheme(
                minWidth: 350,
                height: 150,
                child: RaisedButton(
                  color: Colors.teal,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.call_merge, color: Colors.white, size: 35),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        '업무리스트',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Text(
                          Data.carList.length.toString(),
                          style: TextStyle(fontSize: 20, color: Colors.teal),
                        ),
                      )
                    ],
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  // padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => Task(),
                      ),
                    ).then(syncGG);
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
