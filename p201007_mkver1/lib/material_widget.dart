import 'package:flutter/material.dart';

TableRow taskCar(context, carname, carnumber) {
  return TableRow(
    children: [
      Text(
        carname,
        textAlign: TextAlign.center,
      ),
      Text(
        carnumber,
        textAlign: TextAlign.center,
      ),
      FlatButton(
        color: Colors.black12,
        onPressed: () {
          taskDone(context);
        },
        child: Container(
          child: Icon(Icons.done),
          decoration: BoxDecoration(),
        ),
      ),
    ],
  );
}

TableRow taskCarWithP(context, carname, carnumber, fixList) {
  return TableRow(
    decoration: BoxDecoration(
      color: Colors.red,
    ),
    children: [
      FlatButton(
        onPressed: () {
          needToFixMessage(context, fixList);
        },
        child: Text(
          carname,
          textAlign: TextAlign.center,
        ),
      ),
      FlatButton(
        onPressed: () {
          needToFixMessage(context, fixList);
        },
        child: Text(
          carnumber,
          textAlign: TextAlign.center,
        ),
      ),
      FlatButton(
        color: Colors.black12,
        onPressed: () {
          taskDone(context);
        },
        child: Container(
          child: Icon(Icons.done),
          decoration: BoxDecoration(),
        ),
      ),
    ],
  );
}

Future taskDone(BuildContext context) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Check Please...'),
        content: const Text('Done?'),
        actions: [
          FlatButton(
            child: Text('YES'),
            onPressed: () {
              //차 삭제!
              print('');
              Navigator.of(context).pop();
            },
          ),
          FlatButton(
            child: Text('NO'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

Future needToFixMessage(BuildContext context, fixList) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Fix List'),
        content: Text(fixList),
        actions: [
          FlatButton(
            child: Text('Close'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

List makeRow(context, carList) {
  List<TableRow> rows = [];
  rows.add(defaultRow());
  for (int i = 0; i < carList.length; i++) {
    if (carList[i][2] == true) {
      rows.add(taskCar(context, carList[i][0], carList[i][1]));
    } else {
      rows.add(taskCarWithP(
          context, carList[i][0], carList[i][1], carList[i][3].toString()));
    }
  }
  return rows;
  //get from api
}

Table makeTable(context, carList) {
  return Table(
    //textDirection: TextDirection.rtl,
    columnWidths: {
      // 0: FlexColumnWidth(1),
      // 1: FlexColumnWidth(1),
      2: FlexColumnWidth(.3),
    },
    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
    border: TableBorder(
      top: BorderSide(width: 1, color: Colors.black),
      bottom: BorderSide(width: 1, color: Colors.black),
      left: BorderSide(width: 1, color: Colors.black),
      right: BorderSide(width: 1, color: Colors.black),
      horizontalInside: BorderSide(width: 1, color: Colors.black),
    ),
    children: makeRow(context, carList),
    // [
    //   //carList이용해서 Table 생성.
    //   taskCar(context, "K5", "12허 8915"),
    //   taskCar(context, "AVANTE", "30호 5901"),
    //   taskCar(context, "AVANTE", "30호 5901"),
    //   taskCar(context, "AVANTE", "30호 5901"),
    //   taskCar(context, "AVANTE", "30호 5901"),
    //   taskCarWithP(context, "AUDI", "22호 2222", "엔진오일 교체 필요\n요소수 교체 필요"),
    // ],
  );
}

TableRow defaultRow() {
  return TableRow(
    children: [
      Text(
        "차종",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 30,
        ),
      ),
      Text(
        "차량번호",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 30),
      ),
      Text(
        "",
      ),
    ],
  );
}
