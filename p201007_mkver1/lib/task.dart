import 'package:flutter/material.dart';
import 'mainpage.dart';
import 'material_widget.dart';

class Task extends StatefulWidget {
  @override
  String jf = '';
  _TaskState createState() => _TaskState();
}

class Data {
  static List carList = [
    ['K5', '11허 1111', true, ""],
    ['AVANTE', '22허 2222', false, "요소수 주입\n엔진오일 교체"],
    ['K5', '33허 3333', false, "램프 교체"],
    ['AUDI', '43허 3123', true, ""],
  ];
  static int numberOfCar = carList.length;
}

class _TaskState extends State<Task> {
  int needToFix = 0;
  int normalTask = 0;

  //carList에 위 같은 형태로 넣어주면 됨!@!@!@!@

  void increase() {
    setState(() {
      Data.numberOfCar = Data.numberOfCar + 1;
      String num = (Data.carList.length + 1).toString();
      Data.carList.add(['BMW', num * 2 + '허' + num * 4, true, '']);
      DataMainPage.numberOfTask = Data.carList.length;
    });
  }

  void decrease() {
    setState(() {
      Data.numberOfCar = Data.numberOfCar - 1;
      Data.carList.removeAt(Data.carList.length - 1);
      DataMainPage.numberOfTask = Data.carList.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '업무리스트',
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 150,
                    height: 100,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1),
                      borderRadius: BorderRadius.circular(10),
                      // image: DecorationImage(
                      //   image: AssetImage('image/car.jpg'),
                      // ),
                    ),
                    child: Column(
                      children: [
                        Text("정비필요"),
                        Divider(
                          thickness: 1,
                          color: Colors.black,
                        ),
                        // Text(needToFix.toString()),
                        FlatButton(
                            onPressed: () {
                              increase();
                            },
                            child: Text(Data.numberOfCar.toString()))
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: 150,
                    height: 100,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1),
                      borderRadius: BorderRadius.circular(10),
                      // image: DecorationImage(
                      //   image: AssetImage('image/car.jpg'),
                      // ),
                    ),
                    child: Column(
                      children: [
                        Text('일반업무'),
                        Divider(
                          thickness: 1,
                          color: Colors.black,
                        ),
                        FlatButton(
                            onPressed: () {
                              decrease();
                            },
                            child: Text(normalTask.toString())),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              makeTable(context, Data.carList),
              SizedBox(
                height: 30,
              )
            ], // Column children
          ),
        ),
      ),
    );
  }
}
