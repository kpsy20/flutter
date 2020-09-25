import 'dart:io';
import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:image_size_getter/image_size_getter.dart';

void main() => runApp(MyApp());

//처음 시작하는 곳.
//home은 어플이 시작하고 처음 실행되는 위젯.
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //imageCache.clear();
    return MaterialApp(
      title: "cameratest2",
      home: GetImage(),
    );
  }
}

class Data {
  static double x = 0.0;
  static double y = 0.0;
  static double w = 0.0;
  static double h = 0.0;
}

//여러 요소들이 사용중에 상태가 변하기 때문에 Stateful위젯으로 설정
class GetImage extends StatefulWidget {
  //static const routeName = '/getimage';
  static const routeName = '/';

  @override
  _GetImageState createState() => _GetImageState();
}

class _GetImageState extends State<GetImage> {
  @override
  //이미지를 보낼 주소.(번호판 인식 서버)
  String url =
      "https://dd1m2qqooh.execute-api.ap-northeast-2.amazonaws.com/dev/predict";
  //사진 넣는 창과 결과창에 들어가는 기본 텍스트
  String topText = "\n\n\n\n사진을 넣어주세요";
  String bottomText = "\n\n결과";
  //찍거나 불러올 이미지를 담을 변수
  File _image;
  //카메라, 갤러리 실행위한 ImagePicker
  final picker = ImagePicker();
  //서버에서 받아온 결과값
  var resultName = "";
  var resultProb = "";
  Size size;
  //초기화 버튼 넣으려고 했으나, 작동이 잘 안돼서 안넣음
  Future reset() async {
    setState(() {
      _image = File('image/white_background.png');
      topText = "\n\n\n\n사진을 넣어주세요";
      bottomText = '\n\n결과';
    });
  }

  //이미지를 가져오고 base64로 바꾸고 json으로 바꾸고..등등..
  //서버에 보내는 양식 맞춰줌
  Future getImage(ImageSource imageSource) async {
    final pickedFile = await picker.getImage(source: imageSource);
    //image = await ImagePicker.pickImage(source: imageSource);
    imageCache.clear();
    imageCache.clearLiveImages();

    //final bytes = File(image.path).readAsBytesSync();
    final bytes = File(pickedFile.path).readAsBytesSync();
    size = ImageSizeGetter.getSize(MemoryInput(bytes));
    // size.width, size.height!!!!

    String img64 = base64Encode(bytes);
    Info_ocr obj = new Info_ocr();
    obj.image_base64 = img64;
    obj.detect_check = "Y";
    obj.color_check = "Y";
    obj.model_check = "Y";
    Map<String, String> _body = {
      "image_base64": "",
      "detect_check": "",
      "color_check": "",
      "model_check": ""
    };
    _body['image_base64'] = obj.image_base64;
    _body['detect_check'] = obj.detect_check;
    _body['color_check'] = obj.color_check;
    _body['model_check'] = obj.model_check;

    final msg = jsonEncode(_body);
    //print(msg);

    _makePostRequest(msg);
    //parsedJson에 데이터 들어가 있음. 이제 request하면 될것같은데..

    setState(() {
      topText = '';
      _image = File(pickedFile.path);
      //bottomText = resultBody;
    });
  }

  //서버로 보내는 함수
  Future _makePostRequest(jj) async {
    // set up POST request arguments

    Map<String, String> headers = {"Content-type": "application/json"};

    // make POST request
    bottomText = '\n\nloading...';
    Data.x = 0.0;
    http.Response response = await http.post(url, headers: headers, body: jj);
    //print(response.body);
    String resultFull;
    if (response.body.length == 2) {
      resultFull = "\n\n번호판이 잘 보이게 다시 찍어주세요";
    } else {
      resultName = response.body;
      final f = jsonDecode(response.body);
      print(f);
      resultName = f[0]['text'];
      resultProb = (f[0]['prob'] * 100).toStringAsFixed(1);
      // print(f);
      // print("\n");
      // print(response.headers);
      resultFull = "\n\n번호판: " + resultName + "\n" + resultProb + "%";
      //////////////////size처리/////////////////////
      Data.x = f[0]['box']['x'].toDouble();
      Data.y = f[0]['box']['y'].toDouble();
      Data.w = f[0]['box']['w'].toDouble();
      Data.h = f[0]['box']['h'].toDouble();

      if (size.height < size.width) {
        double divider = size.width / 300.0;
        //divider OK
        print(divider);
        Data.x = Data.x / divider;
        Data.y = Data.y / divider;
        Data.w = Data.w / divider;
        Data.h = Data.h / divider;
        double plus = (300.0 - size.height / divider) / 2.0;
        Data.y = Data.y + plus;
      } else {
        double divider = size.height / 300.0;
        print(divider);

        Data.x = Data.x / divider;
        Data.y = Data.y / divider;
        Data.w = Data.w / divider;
        Data.h = Data.h / divider;
        double plus = (300.0 - size.width / divider) / 2.0;
        Data.x = Data.x + plus;
      }
      print(Data.x);
      print(Data.y);
      print(Data.w);
      print(Data.h);
    }

    // check the status code for the result
    int statusCode = response.statusCode;
    setState(() {
      bottomText = resultFull;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                Center(
                  child: _image == null
                      ? Container(
                          child: Text(
                            '사진을 넣어주세요',
                            textAlign: TextAlign.center,
                          ),
                          height: 300,
                          width: 300,
                        )
                      : Image.file(
                          _image,
                          height: 300,
                          width: 300,
                        ),
                ),
                Center(child: Data.x == 0 ? Text("") : ArcWidget()),
              ],
            ),
            SizedBox(
              height: 30.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FlatButton(
                  onPressed: () {
                    imageCache.clear();
                    getImage(ImageSource.camera);
                  },
                  child: Text("사진 찍기"),
                  color: Colors.pink[100],
                ),
                SizedBox(width: 30),
                FlatButton(
                  onPressed: () {
                    imageCache.clear();
                    getImage(ImageSource.gallery);
                  },
                  child: Text("갤러리"),
                  color: Colors.pink[100],
                ),
                // SizedBox(width: 30),
                // FlatButton(
                //   onPressed: () {
                //     reset();
                //   },
                //   child: Text("초기화"),
                //   color: Colors.pink[100],
                // ),
              ],
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
              height: 100,
              width: 360,
              child: Text(
                bottomText, //\n\n결과
                textAlign: TextAlign.center,
              ),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 3),
                borderRadius: BorderRadius.all(Radius.circular(18)),
                image: DecorationImage(
                  fit: BoxFit.fitWidth,
                  image: AssetImage('image/green_background.png'),
                ),
              ),
            ),
          ],
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
    Rect rect = new Rect.fromLTWH(0.0, 0.0, size.width, size.height);
    Rect re = new Rect.fromLTWH(Data.x, Data.y, Data.w, Data.h);
    canvas
      ..drawRect(
          re,
          Paint()
            ..color = Colors.redAccent
            ..style = PaintingStyle.stroke
            ..strokeWidth = 3);
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

class Info_ocr {
  String image_base64;
  String detect_check;
  String color_check;
  String model_check;
}
