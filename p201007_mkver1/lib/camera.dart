import 'dart:async';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';
import 'package:image_size_getter/image_size_getter.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dataset.dart';

// 사용자가 주어진 카메라를 사용하여 사진을 찍을 수 있는 화면
class Camera4 extends StatefulWidget {
  final CameraDescription camera = Cam.cam;
  @override
  _Camera4State createState() => _Camera4State();
}

class _Camera4State extends State<Camera4> {
  FutureOr syncGG(dynamic value) {
    setState(() {});
  }

  String errorMsg = '';
  String url1 = "http://ai.nextlab.co.kr:9066/detect_car";
  String url2 = "http://ai.nextlab.co.kr:9066/predict_carplate";
  String url3 = "http://ai.nextlab.co.kr:9066/predict_defect";
  String uploadUrl = "http://ai.nextlab.co.kr:8080/image_upload";
  String car_num = '';
  double prob = 0;
  Future<String> uploadImage(filename, url) async {
    var request = http.MultipartRequest('POST', Uri.parse(url));

    // 1. 파라미터 지정정
    request.fields['operation_id'] = "1";
    request.fields['image_type'] = "left";

    // 2. 파일 지정
    request.files.add(await http.MultipartFile.fromPath('file', filename));

    var res = await request.send();
    return res.reasonPhrase;
  }

  //차량인식, 번호판인식, 손상인식 하기위해 서버로 보내는 부분.
  //response, response2, response3에 결과값 저장됨.
  //그리고 위 결과값들을 Map<String, dynamic> result == {"first" : , "second" : , "third" :} 에 담아서 리턴함
  Future<Map> detect_car(String img64) async {
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
      // img64.size
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

  CameraController _controller;
  Future<void> _initializeControllerFuture;
  String order = '전면을 찍어주세요';

  Size size;
  @override
  void initState() {
    super.initState();
    // 카메라의 현재 출력물을 보여주기 위해 CameraController를 생성합니다.
    _controller = CameraController(
      // 이용 가능한 카메라 목록에서 특정 카메라를 가져옵니다.
      widget.camera,
      // 적용할 해상도를 지정합니다.
      ResolutionPreset.ultraHigh,
    );
    // 다음으로 controller를 초기화합니다. 초기화 메서드는 Future를 반환합니다.
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    // 위젯의 생명주기 종료시 컨트롤러 역시 해제시켜줍니다.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //사진 4장찍기 전까지 휴대폰 뒤로가기 버튼 안눌리게 하는부분
    return WillPopScope(
      onWillPop: () {
        setState(
          () {
            flutterToast("4장의 사진을 모두 찍어야 돌아갈 수 있습니다.");
          },
        );
        return Future(() => false);
      },
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: Column(
              children: [
                Text(
                  order,
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 1.2,
                  height: MediaQuery.of(context).size.width / 1.2 * 16 / 9,
                  child: FutureBuilder<void>(
                    future: _initializeControllerFuture,
                    builder: (context, snapshot) {
                      // final size = MediaQuery.of(context).size;
                      // final deviceRatio = size.width / size.height;
                      return snapshot.connectionState != ConnectionState.done
                          ? Center(child: CircularProgressIndicator())
                          : CameraData.whereIsIn == 0
                              ? CameraPreview(
                                  _controller,
                                )
                              : Center(child: CircularProgressIndicator());
                    },
                  ),
                ),
                // SizedBox(height: 20),
                errorMsg == '' ? Text(errorMsg) : Text(errorMsg),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        Container(
                          child: In_Pic.pic1 == null
                              ? Text('')
                              : Image.file(
                                  File(In_Pic.pic1),
                                  width: 80,
                                  height: 80,
                                ),
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 1),
                          ),
                        ),
                        Center(
                            child:
                                In_Pic.pic1 == null ? Text("") : ArcWidget()),
                      ],
                    ),
                    Stack(
                      children: [
                        Container(
                          child: In_Pic.pic2 == null
                              ? Text('')
                              : Image.file(
                                  File(In_Pic.pic2),
                                  width: 80,
                                  height: 80,
                                ),
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 1),
                          ),
                        ),
                        Center(
                            child:
                                In_Pic.pic2 == null ? Text("") : ArcWidget2()),
                      ],
                    ),
                    Stack(
                      children: [
                        Container(
                          child: In_Pic.pic3 == null
                              ? Text('')
                              : Image.file(
                                  File(In_Pic.pic3),
                                  width: 80,
                                  height: 80,
                                ),
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 1),
                          ),
                        ),
                        Center(
                            child:
                                In_Pic.pic3 == null ? Text("") : ArcWidget3()),
                      ],
                    ),
                    Stack(
                      children: [
                        Container(
                          child: In_Pic.pic4 == null
                              ? Text('')
                              : Image.file(
                                  File(In_Pic.pic4),
                                  width: 80,
                                  height: 80,
                                ),
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 1),
                          ),
                        ),
                        Center(
                            child:
                                In_Pic.pic4 == null ? Text("") : ArcWidget4()),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.camera_alt),
          onPressed: () async {
            try {
              if (Frame.frame == 0) {
                errorMsg = "전면 처리중 입니다...";
              }
              if (Frame.frame == 1) {
                errorMsg = "우측면 처리중 입니다...";
              }
              if (Frame.frame == 2) {
                errorMsg = "후면 처리중 입니다...";
              }
              if (Frame.frame == 3) {
                errorMsg = "좌측면 처리중 입니다...";
              }
              CameraData.whereIsIn = 1;

              setState(() {});
              // 카메라 초기화가 완료됐는지 확인합니다.
              if (Frame.frame == 0) {
                await _initializeControllerFuture;
              }
              //사진이 저장 될 path설정
              final path = join(
                (await getTemporaryDirectory()).path,
                '${DateTime.now()}.png',
              );
              //path에 사진 저장
              await _controller.takePicture(path);
              //bytes에 찍은 사진 불러옴
              final bytes = File(path).readAsBytesSync();
              size = ImageSizeGetter.getSize(MemoryInput(bytes));
              print("size" + size.toString());
              //img64에 이미지->base64변환해서 담아줌
              String img64 = base64Encode(bytes);
              //이 밑엔 전후좌우 찍는 과정들..
              //지금은 동기방식(지금 찍은 사진 처리가 끝나야 다음사진을 찍을 수 있음)이여서 되게 느린데 비동기 방식(먼저 사진 4개 다 짝고
              //응답이 오는 순서대로 처리하는 방식) 으로 추후에 바꿔야 할듯함..
              if (Frame.frame == 0) {
                inInfo.x.removeRange(0, inInfo.x.length);
                inInfo.y.removeRange(0, inInfo.y.length);
                inInfo.size_dot.removeRange(0, inInfo.size_dot.length);
                inInfo.color_name.removeRange(0, inInfo.color_name.length);
                final result1 = await detect_car(img64);
                inInfo.r1 = result1;
                print(result1['first']['box']);
                final newSize = sizeControl(size, result1['first']['box']);

                inInfo.car_where.add(newSize);
                inInfo.forPic.add(
                  new Rect.fromLTWH(
                    (inInfo.car_where[0]['x']).toDouble(),
                    (inInfo.car_where[0]['y']).toDouble(),
                    (inInfo.car_where[0]['w']).toDouble(),
                    (inInfo.car_where[0]['h']).toDouble(),
                  ),
                );

                // result1 = await detect_car(img64);
                if (inInfo.r1.containsKey('second')) {
                  if (inInfo.r1['second'].length != 0) {
                    if (inInfo.r1['second']['prob'] > prob) {
                      car_num = inInfo.r1['second']['text'];
                    }
                  }
                }
                if (inInfo.r1['third']['display'].length != 0) //파손 있을 때.
                {
                  for (int i = 0;
                      i < inInfo.r1['third']['display'].length;
                      i++) {
                    inInfo.x.add(
                        inInfo.r1['third']['display'][i]['point'][0] * 15 / 32);
                    inInfo.y.add(
                        inInfo.r1['third']['display'][i]['point'][1] * 15 / 32 +
                            37.5);
                    inInfo.color_name.add(Colors.red);
                    inInfo.size_dot.add(3);
                  }
                }
                inInfo.t1 = inInfo.r1['third']['display'].length.toString() +
                    " Defect(s)";
                errorMsg = '';
              }
              if (Frame.frame == 1) {
                final result2 = await detect_car(img64);
                inInfo.r2 = result2;
                final newSize = sizeControl(size, result2['first']['box']);
                inInfo.car_where.add(newSize);
                inInfo.forPic.add(
                  new Rect.fromLTWH(
                    (inInfo.car_where[1]['x']).toDouble(),
                    (inInfo.car_where[1]['y']).toDouble(),
                    (inInfo.car_where[1]['w']).toDouble(),
                    (inInfo.car_where[1]['h']).toDouble(),
                  ),
                );
                if (inInfo.r2.containsKey('second')) {
                  if (inInfo.r2['second'].length != 0) {
                    if (inInfo.r2['second']['prob'] > prob) {
                      car_num = inInfo.r2['second']['text'];
                    }
                  }
                }
                if (inInfo.r2['third']['display'].length != 0) //파손 있을 때.
                {
                  for (int i = 0;
                      i < inInfo.r2['third']['display'].length;
                      i++) {
                    inInfo.x.add(
                        inInfo.r2['third']['display'][i]['point'][0] * 15 / 32);
                    inInfo.y.add(
                        inInfo.r2['third']['display'][i]['point'][1] * 15 / 32 +
                            37.5);
                    inInfo.color_name.add(Colors.red);
                    inInfo.size_dot.add(3);
                  }
                }
                inInfo.t2 = inInfo.r2['third']['display'].length.toString() +
                    " Defect(s)";
                errorMsg = '';
              }
              if (Frame.frame == 2) {
                final result3 = await detect_car(img64);
                inInfo.r3 = result3;
                final newSize = sizeControl(size, result3['first']['box']);
                inInfo.car_where.add(newSize);
                inInfo.forPic.add(
                  new Rect.fromLTWH(
                    (inInfo.car_where[2]['x']).toDouble(),
                    (inInfo.car_where[2]['y']).toDouble(),
                    (inInfo.car_where[2]['w']).toDouble(),
                    (inInfo.car_where[2]['h']).toDouble(),
                  ),
                );
                if (inInfo.r3.containsKey('second')) {
                  if (inInfo.r3['second'].length != 0) {
                    if (inInfo.r3['second']['prob'] > prob) {
                      car_num = inInfo.r3['second']['text'];
                    }
                  }
                }
                if (inInfo.r3['third']['display'].length != 0) //파손 있을 때.
                {
                  for (int i = 0;
                      i < inInfo.r3['third']['display'].length;
                      i++) {
                    inInfo.x.add(
                        inInfo.r3['third']['display'][i]['point'][0] * 15 / 32);
                    inInfo.y.add(
                        inInfo.r3['third']['display'][i]['point'][1] * 15 / 32 +
                            37.5);
                    inInfo.color_name.add(Colors.red);
                    inInfo.size_dot.add(3);
                  }
                }
                inInfo.t3 = inInfo.r3['third']['display'].length.toString() +
                    " Defect(s)";
                errorMsg = '';
              }
              if (Frame.frame == 3) {
                final result4 = await detect_car(img64);
                inInfo.r4 = result4;
                final newSize = sizeControl(size, result4['first']['box']);
                inInfo.car_where.add(newSize);
                inInfo.forPic.add(
                  new Rect.fromLTWH(
                    (inInfo.car_where[3]['x']).toDouble(),
                    (inInfo.car_where[3]['y']).toDouble(),
                    (inInfo.car_where[3]['w']).toDouble(),
                    (inInfo.car_where[3]['h']).toDouble(),
                  ),
                );
                if (inInfo.r4.containsKey('second')) {
                  if (inInfo.r4['second'].length != 0) {
                    if (inInfo.r4['second']['prob'] > prob) {
                      car_num = inInfo.r4['second']['text'];
                    }
                  }
                }
                if (inInfo.r4['third']['display'].length != 0) //파손 있을 때.
                {
                  for (int i = 0;
                      i < inInfo.r4['third']['display'].length;
                      i++) {
                    inInfo.x.add(
                        inInfo.r4['third']['display'][i]['point'][0] * 15 / 32);
                    inInfo.y.add(
                        inInfo.r4['third']['display'][i]['point'][1] * 15 / 32 +
                            37.5);
                    inInfo.color_name.add(Colors.red);
                    inInfo.size_dot.add(3);
                  }
                }
                inInfo.t4 = inInfo.r4['third']['display'].length.toString() +
                    " Defect(s)";
                errorMsg = '';

                inInfo.car_number = car_num; //제일 prob높은 car_num 넘겨줌
              }
              //여기 왔다는건 차량 인식이 됐다는 소리
              var res = await uploadImage(path, uploadUrl);
              print(res);
              //전후좌우 판단하기 위한 변수
              Frame.frame = Frame.frame + 1;
              int num = Frame.frame;
              String file_name = 'pic' + '$num';
              CameraData.whereIsIn = 0;
              setState(() {});
              //입고 또는 출고에서 왔는지 판단하는 변수
              if (Frame.in_or_out == 'in') {
                In_Pic.Set(file_name, path);
              } else {
                Out_Pic.Set(file_name, path);
              }

              if (Frame.frame != 4) {
                //이제 4장 다 찍으면
              } else {
                Frame.frame = 0;
                Navigator.pop(context);
              }
            } catch (e) {
              // 만약 에러가 발생하면, 콘솔에 에러 로그를 남깁니다.
              List<String> errorList = ['전면', '오른쪽 측면', '후면', '왼쪽 측면'];
              flutterToast(errorList[Frame.frame] + "사진을 다시 찍어주세요.");
              CameraData.whereIsIn = 0;
              errorMsg = errorList[Frame.frame] + " 사진을 다시 찍어주세요";

              print("ERROR!!!!!!!!!!!!!!!!!!!!!!!ERROR");
              print(e);
            }
            setState(
              () {
                if (Frame.frame == 1) {
                  order = '오른쪽 측면을 찍어주세요';
                }
                if (Frame.frame == 2) {
                  order = '후면을 찍어주세요';
                }
                if (Frame.frame == 3) {
                  order = '왼쪽 측면을 찍어주세요';
                }
              },
            );
          },
        ),
      ),
    );
  }
}

// 사용자가 촬영한 사진을 보여주는 위젯
class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({Key key, this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Display the Picture'),
      ),
      // 이미지는 디바이스에 파일로 저장됩니다. 이미지를 보여주기 위해 주어진
      // 경로로 `Image.file`을 생성하세요.
      body: Image.file(File(imagePath)),
    );
  }
}

Map<dynamic, dynamic> sizeControl(Size wh, Map box) {
  double nboxx, nboxy, nboxw, nboxh;
  if (wh.width > wh.height) {
    double mul = 80 / wh.width;
    double nh = mul * wh.height;
    nboxx = box['x'] * mul;
    nboxy = box['y'] * mul + (80 - nh) / 2;
    nboxw = box['w'] * mul;
    nboxh = box['h'] * mul;
  } else {
    double mul = 80 / wh.height;
    double nw = mul * wh.width;
    nboxx = box['x'] * mul + (80 - nw) / 2;
    nboxy = box['y'] * mul;
    nboxw = box['w'] * mul;
    nboxh = box['h'] * mul;
  }
  return {"x": nboxx, "y": nboxy, "w": nboxw, "h": nboxh};
}

void flutterToast(String msgg) {
  Fluttertoast.showToast(
    msg: msgg,
    gravity: ToastGravity.CENTER,
    backgroundColor: Colors.red,
    fontSize: 15.0,
    textColor: Colors.white,
    toastLength: Toast.LENGTH_SHORT,
  );
}

class _ArcPainter extends CustomPainter {
  _ArcPainter();

  @override
  bool shouldRepaint(_ArcPainter oldDelegate) {
    return true;
  }

  @override
  void paint(Canvas canvas, size) {
    if (inInfo.forPic.length != 0) {
      canvas
        ..drawRect(
            inInfo.forPic[0],
            Paint()
              ..color = Colors.red
              ..style = PaintingStyle.stroke
              ..strokeWidth = 2);
    }
  }
}

class ArcWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new SizedBox(
      width: 80.0,
      height: 80.0,
      child: new CustomPaint(
        painter: new _ArcPainter(),
      ),
    );
  }
}

class ArcWidget2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new SizedBox(
      width: 80.0,
      height: 80.0,
      child: new CustomPaint(
        painter: new _ArcPainter2(),
      ),
    );
  }
}

class _ArcPainter2 extends CustomPainter {
  _ArcPainter2();

  @override
  bool shouldRepaint(_ArcPainter2 oldDelegate) {
    return true;
  }

  @override
  void paint(Canvas canvas, size) {
    if (inInfo.forPic.length > 1) {
      canvas
        ..drawRect(
            inInfo.forPic[1],
            Paint()
              ..color = Colors.red
              ..style = PaintingStyle.stroke
              ..strokeWidth = 2);
    }
  }
}

class ArcWidget3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new SizedBox(
      width: 80.0,
      height: 80.0,
      child: new CustomPaint(
        painter: new _ArcPainter3(),
      ),
    );
  }
}

class _ArcPainter3 extends CustomPainter {
  _ArcPainter3();

  @override
  bool shouldRepaint(_ArcPainter3 oldDelegate) {
    return true;
  }

  @override
  void paint(Canvas canvas, size) {
    if (inInfo.forPic.length > 2) {
      canvas
        ..drawRect(
            inInfo.forPic[2],
            Paint()
              ..color = Colors.red
              ..style = PaintingStyle.stroke
              ..strokeWidth = 2);
    }
  }
}

class ArcWidget4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new SizedBox(
      width: 80.0,
      height: 80.0,
      child: new CustomPaint(
        painter: new _ArcPainter4(),
      ),
    );
  }
}

class _ArcPainter4 extends CustomPainter {
  _ArcPainter4();

  @override
  bool shouldRepaint(_ArcPainter4 oldDelegate) {
    return true;
  }

  @override
  void paint(Canvas canvas, size) {
    if (inInfo.forPic.length > 3) {
      canvas
        ..drawRect(
            inInfo.forPic[3],
            Paint()
              ..color = Colors.red
              ..style = PaintingStyle.stroke
              ..strokeWidth = 2);
    }
  }
}
