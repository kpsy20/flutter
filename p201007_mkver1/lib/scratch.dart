import 'package:flutter/material.dart';
import 'dataset.dart';

class Scratch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("손상여부확인"),
        backgroundColor: Colors.teal,
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                  width: 300,
                  height: 100,
                  decoration: BoxDecoration(
                      color: Colors.blue[300],
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: FlatButton(
                      onPressed: () {
                        inInfo.x.removeAt(inInfo.index);
                        inInfo.y.removeAt(inInfo.index);
                        inInfo.color_name.removeAt(inInfo.index);
                        Navigator.pop(context);
                      },
                      child: Text(
                        "이상없음",
                        style: TextStyle(color: Colors.white),
                      ))),
              Container(
                  width: 300,
                  height: 100,
                  decoration: BoxDecoration(
                      color: Colors.blue[300],
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: FlatButton(
                      onPressed: () {
                        inInfo.color_name[inInfo.index] = Colors.blue;
                        inInfo.size_dot[inInfo.index] = 3;
                        Navigator.pop(context);
                      },
                      child:
                          Text("무시", style: TextStyle(color: Colors.white)))),
              Container(
                  width: 300,
                  height: 100,
                  decoration: BoxDecoration(
                      color: Colors.blue[300],
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: FlatButton(
                      onPressed: () {
                        inInfo.color_name[inInfo.index] = Colors.yellow;
                        inInfo.size_dot[inInfo.index] = 3;
                        Navigator.pop(context);
                      },
                      child:
                          Text("정비필요", style: TextStyle(color: Colors.white)))),
            ],
          ),
        ),
      ),
    );
  }
}
