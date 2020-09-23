import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "cameratest2",
      home: GetImage(),
    );
  }
}

class GetImage extends StatefulWidget {
  static const routeName = '/getimage';

  @override
  _GetImageState createState() => _GetImageState();
}

class _GetImageState extends State<GetImage> {
  @override
  String url =
      "https://dd1m2qqooh.execute-api.ap-northeast-2.amazonaws.com/dev/predict";

  String topText = "\n\n\n\n사진을 넣어주세요";
  String bottomText = "\n\n결과";
  File _image;
  Image im = Image.asset('image/green_background.png');
  AssetImage topImage = AssetImage('image/green_background.png');
  var resultName = "";
  var resultProb = "";
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(0.0, 50.0, 0.0, 0.0),
              height: 360,
              width: 360,
              child: Text(
                topText,
                textAlign: TextAlign.center,
              ),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 3),
                borderRadius: BorderRadius.all(Radius.circular(18)),
                image: DecorationImage(
                  fit: BoxFit.fitWidth,
                  image: topImage,
                ),
              ),
            ),
            // Container(
            //   color: Colors.teal,
            //   height: 360,
            //   width: 360,
            //   child: Text(
            //     '차량 이미지를 넣어주세요',
            //     textAlign: TextAlign.center,
            //   ),
            //   margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
            // ),
            SizedBox(
              height: 30.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FlatButton(
                  onPressed: () {
                    getImage(ImageSource.camera);
                  },
                  child: Text("사진 찍기"),
                  color: Colors.pink[100],
                ),
                SizedBox(width: 30),
                FlatButton(
                  onPressed: () {
                    getImage(ImageSource.gallery);
                  },
                  child: Text("갤러리"),
                  color: Colors.pink[100],
                ),
                SizedBox(width: 30),
                FlatButton(
                  onPressed: () {
                    reset();
                  },
                  child: Text("초기화"),
                  color: Colors.pink[100],
                ),
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
            showImage(),
          ],
        ),
      ),
    );
  }

  Widget showImage() {
    if (_image == null) {
      return Container();
    } else {
      return Image.file(_image);
    }
  }

  Future reset() {
    setState(() {
      imageCache.clear();
      topImage = AssetImage('image/green_background.png');
      topText = "\n\n\n\n사진을 넣어주세요";
      bottomText = '\n\n결과';
    });
  }

  Future getImage(ImageSource imageSource) async {
    File image = await ImagePicker.pickImage(source: imageSource);
    final bytes = await File(image.path).readAsBytesSync();
    String img64 = base64Encode(bytes);
    Info_ocr obj = new Info_ocr();
    obj.image_base64 = img64;
    obj.detect_check = "N";
    obj.color_check = "N";
    obj.model_check = "N";
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
    print(msg);

    _makePostRequest(msg);
    //parsedJson에 데이터 들어가 있음. 이제 request하면 될것같은데..

    setState(() {
      imageCache.clear();

      topImage = AssetImage(image.path);
      topText = '';
      //bottomText = resultBody;
    });
  }

  Future _makePostRequest(jj) async {
    // set up POST request arguments

    Map<String, String> headers = {"Content-type": "application/json"};

    // make POST request
    http.Response response = await http.post(url, headers: headers, body: jj);
    print(response.body);
    String resultFull;
    if (response.body.length == 2) {
      resultFull = "\n\n번호판이 잘 보이게 다시 찍어주세요";
    } else {
      resultName = response.body;
      final f = jsonDecode(response.body);
      resultName = f[0]['text'];
      resultProb = (f[0]['prob'] * 100).toStringAsFixed(1);

      resultFull = "\n\n번호판: " + resultName + "\n" + resultProb + "%";
    }

    // check the status code for the result
    int statusCode = response.statusCode;
    print(statusCode);
    // this API passes back the id of the new item added to the body
    // {
    //   "title": "Hello",
    //   "body": "body text",
    //   "userId": 1,
    //   "id": 101
    // }
    setState(() {
      bottomText = resultFull;
    });
  }
}

// class JSONTest extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     String json =
//         '{"name":"John Smith", "email":"john@example.com", "created_time":"123123123123"}';
//     Map<String, dynamic> userMap = jsonDecode(json);
//     return Scaffold(
//       body: Text(
//           'name: ${userMap['name']} \n email: ${userMap['email']} \n created_time: ${userMap['email']}'),
//     );
//   }
// }

class Info_ocr {
  String image_base64;
  String detect_check;
  String color_check;
  String model_check;
}
