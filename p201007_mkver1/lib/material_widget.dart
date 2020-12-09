import 'dart:io';
import 'in.dart';
import 'package:flutter/material.dart';
import 'out.dart';

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

void left(setState) {
  setState(() {
    if (inInfo.index == 1) {
      inInfo.index = 4;
    } else {
      inInfo.index--;
    }
  });
}

void right(setState) {
  setState(() {
    if (inInfo.index == 4) {
      inInfo.index = 1;
    } else {
      inInfo.index++;
    }
  });
}

Future scratchPic(BuildContext context) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, StateSetter setState) {
          return AlertDialog(
            title: Text(
              "손상여부확인",
              textAlign: TextAlign.center,
            ),
            // content: ,
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
    },
  );
}

List<Container> scratchList(
    List<double> x, List<double> y, BuildContext context) {
  List<Container> result = [];
  for (int i = 0; i < x.length; i++) {
    result.add(
      Container(
        child: FlatButton(
          onPressed: () {
            Navigator.pop(context);
            scratchPic(context);
          },
          child: Text((i + 1).toString() +
              "번 손상 (" +
              x[i].toString() +
              ", " +
              y[i].toString() +
              ")"),
        ),
      ),
    );
  }
  return result;
}

Future showScratch(BuildContext context, List<double> x, List<double> y) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, StateSetter setState) {
          return AlertDialog(
            title: Text(
              "손상 목록",
              textAlign: TextAlign.center,
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: scratchList(x, y, context),
            ),
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
    },
  );
}

Future inPic(
    BuildContext context, car_num, image1, image2, image3, image4, index) {
  var showImage;
  if (index == 1) {
    showImage = image1;
  } else if (index == 2) {
    showImage = image2;
  } else if (index == 3) {
    showImage = image3;
  } else {
    showImage = image4;
  }
  inInfo.index = index;
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, StateSetter setState) {
          return AlertDialog(
            title: Text(
              "자세한 차량 사진",
              textAlign: TextAlign.center,
            ),
            content: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(car_num),
                  Text(inInfo.index.toString() + '/4'),
                  Container(
                    child: showImage == null
                        ? Text('')
                        : Image.file(
                            File(showImage),
                            width: 300,
                            height: 240,
                          ),
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    ButtonTheme(
                      minWidth: 30,
                      height: 30,
                      child: RaisedButton(
                        color: Colors.white,
                        child: Icon(Icons.arrow_back),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        // padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
                        onPressed: () {
                          if (inInfo.index == 1) {
                            showImage = image4;
                          } else if (inInfo.index == 2) {
                            showImage = image1;
                          } else if (inInfo.index == 3) {
                            showImage = image2;
                          } else {
                            showImage = image3;
                          }
                          left(setState);
                        },

                        // Navigator.pop(context);
                        // inPic(
                        //     context, car_num, 4, image1, image2, image3, image4);
                        // if (index == 1) {
                        //   showImage = image4;
                        // }
                      ),
                    ),
                    SizedBox(
                      width: 110,
                    ),
                    ButtonTheme(
                      minWidth: 30,
                      height: 30,
                      child: RaisedButton(
                        color: Colors.white,
                        child: Icon(Icons.arrow_forward),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        // padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
                        onPressed: () {
                          if (inInfo.index == 1) {
                            showImage = image2;
                          } else if (inInfo.index == 2) {
                            showImage = image3;
                          } else if (inInfo.index == 3) {
                            showImage = image4;
                          } else {
                            showImage = image1;
                          }
                          right(setState);
                        },
                      ),
                    ),
                  ]),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ButtonTheme(
                        minWidth: 100,
                        height: 30,
                        child: RaisedButton(
                          color: Colors.teal,
                          child: Text(
                            '이전사진',
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
                        width: 20,
                      ),
                      ButtonTheme(
                        minWidth: 100,
                        height: 30,
                        child: RaisedButton(
                          color: Colors.teal,
                          child: Text(
                            '현재사진',
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
                    ],
                  ),
                ]),
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
    },
  );
}

void leftO(setState) {
  setState(() {
    if (outInfo.index == 1) {
      outInfo.index = 4;
    } else {
      outInfo.index--;
    }
  });
}

void rightO(setState) {
  setState(() {
    if (outInfo.index == 4) {
      outInfo.index = 1;
    } else {
      outInfo.index++;
    }
  });
}

Future outPic(
    BuildContext context, car_num, image1, image2, image3, image4, index) {
  var showImage;
  if (index == 1) {
    showImage = image1;
  } else if (index == 2) {
    showImage = image2;
  } else if (index == 3) {
    showImage = image3;
  } else {
    showImage = image4;
  }
  outInfo.index = index;
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, StateSetter setState) {
          return AlertDialog(
            title: Text(
              "자세한 차량 사진",
              textAlign: TextAlign.center,
            ),
            content: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(car_num),
                  Text(outInfo.index.toString() + '/4'),
                  Container(
                    child: showImage == null
                        ? Text('')
                        : Image.file(
                            File(showImage),
                            width: 300,
                            height: 240,
                          ),
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    ButtonTheme(
                      minWidth: 30,
                      height: 30,
                      child: RaisedButton(
                        color: Colors.white,
                        child: Icon(Icons.arrow_back),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        // padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
                        onPressed: () {
                          if (outInfo.index == 1) {
                            showImage = image4;
                          } else if (outInfo.index == 2) {
                            showImage = image1;
                          } else if (outInfo.index == 3) {
                            showImage = image2;
                          } else {
                            showImage = image3;
                          }
                          leftO(setState);
                        },

                        // Navigator.pop(context);
                        // inPic(
                        //     context, car_num, 4, image1, image2, image3, image4);
                        // if (index == 1) {
                        //   showImage = image4;
                        // }
                      ),
                    ),
                    SizedBox(
                      width: 110,
                    ),
                    ButtonTheme(
                      minWidth: 30,
                      height: 30,
                      child: RaisedButton(
                        color: Colors.white,
                        child: Icon(Icons.arrow_forward),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        // padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
                        onPressed: () {
                          if (outInfo.index == 1) {
                            showImage = image2;
                          } else if (outInfo.index == 2) {
                            showImage = image3;
                          } else if (outInfo.index == 3) {
                            showImage = image4;
                          } else {
                            showImage = image1;
                          }
                          rightO(setState);
                        },
                      ),
                    ),
                  ]),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ButtonTheme(
                        minWidth: 100,
                        height: 30,
                        child: RaisedButton(
                          color: Colors.teal,
                          child: Text(
                            '이전사진',
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
                        width: 20,
                      ),
                      ButtonTheme(
                        minWidth: 100,
                        height: 30,
                        child: RaisedButton(
                          color: Colors.teal,
                          child: Text(
                            '현재사진',
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
                    ],
                  ),
                ]),
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
    },
  );
}
