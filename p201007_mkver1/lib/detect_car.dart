import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter/material.dart';
import 'dataset.dart';

class Detect_car extends StatefulWidget {
  static int percent = 0;
  static double pp = 0;
  @override
  _Detect_carState createState() => _Detect_carState();
}

class _Detect_carState extends State<Detect_car> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("처리중 입니다...")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                width: MediaQuery.of(context).size.width / 4,
                height: MediaQuery.of(context).size.width / 4,
                child: CircularProgressIndicator()),
            Container(
              width: MediaQuery.of(context).size.width / 8,
              height: MediaQuery.of(context).size.width / 8,
              child: FlatButton(
                child: Icon(Icons.backspace),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width / 8,
              height: MediaQuery.of(context).size.width / 8,
              child: FlatButton(
                child: Icon(Icons.golf_course),
                onPressed: () {
                  send1().then;
                },
              ),
            ),
            new CircularPercentIndicator(
              radius: 100.0,
              lineWidth: 5.0,
              percent: Detect_car.pp,
              center: new Text(Detect_car.percent.toString()),
              progressColor: Colors.green,
            ),
          ],
        ),
      ),
    );
  }
}

//In_Pic.pic1, ~ In_Pic.pic4
Future<Map> detect_car(String img64) async {
  String url1 = "http://ai.nextlab.co.kr:9066/detect_car";
  String url2 = "http://ai.nextlab.co.kr:9066/predict_carplate";
  String url3 = "http://ai.nextlab.co.kr:9066/predict_defect";
  //서버로 보내는 형식에 맞게 바꿔주는 중
  Map<String, String> param_dict = {"base64_image": img64};
  Map<String, String> headers = {"Content-type": "application/json"};
  final msg = jsonEncode(param_dict);
  //서버로 요청 보냄
  http.Response response = await http.post(url1, headers: headers, body: msg);
  //응답 받은거 저장
  final first = jsonDecode(response.body);
  print(first);
  //response에 box라는 key값이 있다면(제대로 응답이 왔다면)
  if (first.containsKey("box")) {
    final car_box = first['box'];
    //carplate
    bool front_or_back = false;
    var second;
    //그리고 제대로 응답이 왔을 때, 차량의 위치가 front나 back일 경우 번호판 인식하는 부분
    if (first['direction'] == 'front' || first['direction'] == 'back') {
      //서버로 요청 보냄
      http.Response response2 =
          await http.post(url2, headers: headers, body: msg);
      second = jsonDecode(response2.body);
      front_or_back = true;
    }
    String direction = first['direction'];
    double threshold = 0.7;
    //이제 마지막으로 손상인식 하기전 형식 맞춰줌
    Map<String, dynamic> last_param_dict = {
      "base64_image": img64,
      "direction": direction,
      "roi_box": car_box,
      "threshold": threshold,
    };
    final last_msg = jsonEncode(last_param_dict);
    //손상인식 서버로 보냄
    http.Response response3 =
        await http.post(url3, headers: headers, body: last_msg);
    final third = jsonDecode(response3.body);
    print("number1DEFECT!!!!!!!!!!!!!!!!!!!!!!!!!!");
    print(third);
    Map<String, dynamic> result;
    //front또는 back일 때는 번호판(second)가 있으니 key값이 first, second, third이고, 아니면 번호판 없으니 first, third만 있음.
    if (front_or_back) {
      result = {"first": first, "second": second, "third": third};
    } else {
      result = {"first": first, "third": third};
    }
    return result;
  } else {
    //차량인식을 못했을 때 여기로 옴
    print("Detection Failed");
  }
}

Future<void> send1() async {
  File picture = File(In_Pic.Get('pic1'));
  final bytes = picture.readAsBytesSync();
  String img64 = base64Encode(bytes);
  var w = await detect_car(img64);
  Detect_car.pp = 0.25;
}

Future<void> send2() async {
  File picture = File(In_Pic.Get('pic2'));
  final bytes = picture.readAsBytesSync();
  String img64 = base64Encode(bytes);
  var w = await detect_car(img64);
  Detect_car.pp = 0.5;
}

Future<void> send3() async {
  File picture = File(In_Pic.Get('pic3'));
  final bytes = picture.readAsBytesSync();
  String img64 = base64Encode(bytes);
  var w = await detect_car(img64);
  Detect_car.pp = 0.75;
}

Future<void> send4(context) async {
  File picture = File(In_Pic.Get('pic4'));
  final bytes = picture.readAsBytesSync();
  String img64 = base64Encode(bytes);
  var w = await detect_car(img64);
  Detect_car.pp = 1;
  Navigator.pop(context);
}
