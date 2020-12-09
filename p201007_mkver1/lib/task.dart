import 'package:flutter/material.dart';
import 'material_widget.dart';
import 'dataset.dart';

class Task extends StatefulWidget {
  @override
  _TaskState createState() => _TaskState();
}

class _TaskState extends State<Task> {
  int needToFix = 0;
  int normalTask = 0;

  //carList에 위 같은 형태로 넣어주면 됨!@!@!@!@

  void increase() {
    setState(() {
      String num = (Data.carList.length + 1).toString();
      Data.carList.add(['BMW', num * 2 + '허 ' + num * 4, true, '']);
    });
  }

  void decrease() {
    setState(() {
      Data.carList.removeAt(Data.carList.length - 1);
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
                        FlatButton(
                            onPressed: () {
                              increase();
                            },
                            child: Text(Data.carList.length.toString()))
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
