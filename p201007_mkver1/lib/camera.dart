import 'dart:async';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:p201007_mkver1/in.dart';
import 'in.dart';
import 'main.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';
import 'out.dart';
import 'package:image_size_getter/image_size_getter.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

// 사용자가 주어진 카메라를 사용하여 사진을 찍을 수 있는 화면
class Camera4 extends StatefulWidget {
  final CameraDescription camera = Cam.cam;

  // const Camera4({
  //   Key key,
  //   @required this.camera,
  // }) : super(key: key);

  @override
  _Camera4State createState() => _Camera4State();
}

class _Camera4State extends State<Camera4> {
  String errorMsg = '';
  String url1 = "http://ai.nextlab.co.kr:9066/detect_car";
  String url2 = "http://ai.nextlab.co.kr:9066/predict_carplate";
  String url3 = "http://ai.nextlab.co.kr:9066/predict_defect";
  StreamController<Map<String, dynamic>> streamController =
      StreamController(); // 데이터를 받아들이는 스트림.
  String car_num = '';
  double prob = 0;
  Future<Map> detect_car(String img64) async {
    Map<String, String> param_dict = {"base64_image": img64};
    Map<String, String> headers = {"Content-type": "application/json"};
    final msg = jsonEncode(param_dict);
    print("BEFORE HTTP!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    // http.Client _client = http.Client(); // http 클라이언트 사용

    // await _client
    // .get(url1)
    // .then((res) => res.body)
    // .then(json.decode);

    http.Response response = await http.post(url1, headers: headers, body: msg);
    print("number1CARLOCATE!!!!!!!!!!!!!!!!!!!!!!!!!");
    // print("RESPONESE" + response.body);

    final first = jsonDecode(response.body);
    print(first);
    if (first.containsKey("box")) {
      final car_box = first['box'];
      //carplate
      bool front_or_back = false;
      var second;
      if (first['direction'] == 'front' || first['direction'] == 'back') {
        http.Response response2 =
            await http.post(url2, headers: headers, body: msg);
        second = jsonDecode(response2.body);
        //String carplate_text = second['text'];
        //double carplate_prob = second['prob'];
        print("number1CARPLATE!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
        print(second);
        front_or_back = true;
      }
      String direction = first['direction'];
      double threshold = 0.7;
      Map<String, dynamic> last_param_dict = {
        "base64_image": img64,
        "direction": direction,
        "roi_box": car_box,
        "threshold": threshold,
      };
      final last_msg = jsonEncode(last_param_dict);
      http.Response response3 =
          await http.post(url3, headers: headers, body: last_msg);
      final third = jsonDecode(response3.body);
      print("number1DEFECT!!!!!!!!!!!!!!!!!!!!!!!!!!");
      print(third);
      Map<String, dynamic> result;
      if (front_or_back) {
        result = {"first": first, "second": second, "third": third};
      } else {
        result = {"first": first, "third": third};
      }
      return result;
    } else {
      // 차 인식 안됐음. 아예 안하기. 그리고 알려주기. 몇번째 사진이 인식이 안됐는지.
      print("인식 안됐음!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    }
  }

  CameraController _controller;
  Future<void> _initializeControllerFuture;
  String order = '전면을 찍어주세요';

  Size size;
  var result1, result2, result3, result4;
  @override
  void initState() {
    super.initState();
    // 카메라의 현재 출력물을 보여주기 위해 CameraController를 생성합니다.
    _controller = CameraController(
      // 이용 가능한 카메라 목록에서 특정 카메라를 가져옵니다.
      widget.camera,
      // 적용할 해상도를 지정합니다.
      ResolutionPreset.veryHigh,
    );
    // 다음으로 controller를 초기화합니다. 초기화 메서드는 Future를 반환합니다.
    // CameraValue(previewSize: Size(720, 720));
//위에꺼 안먹힘
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
    return WillPopScope(
      onWillPop: () {
        setState(
          () {
            flutterToast();
          },
        );
        return Future(() => false);
      },
      child: Scaffold(
        // appBar: AppBar(title: Text('차량 전면부를 찍어 주세요')),
        // 카메라 프리뷰를 보여주기 전에 컨트롤러 초기화를 기다려야 합니다. 컨트롤러 초기화가
        // 완료될 때까지 FutureBuilder를 사용하여 로딩 스피너를 보여주세요.

        // body: ClipRect(
        //   child: Container(
        //     child: Transform.scale(
        //         scale: _controller.value.aspectRatio,
        //         child: AspectRatio(
        //           aspectRatio: _controller.value.aspectRatio,
        //           child: CameraPreview(_controller),
        //         )),
        //   ),
        // ),

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
                  width: 400,
                  height: 700,
                  // child: AspectRatio(
                  //   aspectRatio: 1,
                  //   child: Transform(
                  //     alignment: Alignment.center,
                  //     transform: Matrix4.diagonal3Values(1, 1, 1),
                  //     child: FutureBuilder<void>(
                  //       future: _initializeControllerFuture,
                  //       builder: (context, snapshot) {
                  //         // final size = MediaQuery.of(context).size;
                  //         // final deviceRatio = size.width / size.height;
                  //         if (snapshot.connectionState ==
                  //             ConnectionState.done) {
                  //           // Future가 완료되면, 프리뷰를 보여줍니다.
                  //           return CameraPreview(
                  //             _controller,
                  //           );
                  //         } else {
                  //           // 그렇지 않다면, 진행 표시기를 보여줍니다.
                  //           return Center(child: CircularProgressIndicator());
                  //         }
                  //       },
                  //     ),
                  //   ),
                  // ),

                  ///
                  child: FutureBuilder<void>(
                    future: _initializeControllerFuture,
                    builder: (context, snapshot) {
                      // final size = MediaQuery.of(context).size;
                      // final deviceRatio = size.width / size.height;
                      if (snapshot.connectionState == ConnectionState.done) {
                        // Future가 완료되면, 프리뷰를 보여줍니다.
                        return CameraPreview(
                          _controller,
                        );
                      } else {
                        // 그렇지 않다면, 진행 표시기를 보여줍니다.
                        return Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                ),
                SizedBox(height: 20),
                Text(errorMsg),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.camera_alt),
          // onPressed 콜백을 제공합니다.
          onPressed: () async {
            //사진 찍혔을 때!!!!!!!!!! 여기서 api요청 보내야됨......
            try {
              // 카메라 초기화가 완료됐는지 확인합니다.
              if (Frame.frame == 0) {
                await _initializeControllerFuture;
              }

              // path 패키지를 사용하여 이미지가 저장될 경로를 지정합니다.
              final path = join(
                // 본 예제에서는 임시 디렉토리에 이미지를 저장합니다. `path_provider`
                // 플러그인을 사용하여 임시 디렉토리를 찾으세요.
                (await getTemporaryDirectory()).path,
                '${DateTime.now()}.png',
              );

              // 사진 촬영을 시도하고 저장되는 경로를 로그로 남깁니다.
              await _controller.takePicture(path);
              final bytes = File(path).readAsBytesSync();
              size = ImageSizeGetter.getSize(MemoryInput(bytes));
              String img64 = base64Encode(bytes);

              if (Frame.frame == 0) {
                inInfo.x.removeRange(0, inInfo.x.length);
                inInfo.y.removeRange(0, inInfo.y.length);
                inInfo.r1 = await detect_car(img64);
                // result1 = await detect_car(img64);
                if (inInfo.r1.containsKey('second')) {
                  if (inInfo.r1['second'].length != 0) {
                    if (inInfo.r1['second']['prob'] > prob) {
                      car_num = inInfo.r1['second']['text'];
                    }
                  }
                }
                if (inInfo.r1['third'].length != 0) //파손 있을 때.
                {
                  for (int i = 0; i < inInfo.r1['third'].length; i++) {
                    inInfo.x.add(
                        inInfo.r1['third'][i]['mapping_point'][0] * 15 / 32);
                    inInfo.y.add(
                        inInfo.r1['third'][i]['mapping_point'][1] * 15 / 32 +
                            37.5);
                  }
                }
                inInfo.t1 = inInfo.r1['third'].length.toString() + " Defect(s)";
                errorMsg = '';
              }
              if (Frame.frame == 1) {
                inInfo.r2 = await detect_car(img64);
                if (inInfo.r2.containsKey('second')) {
                  if (inInfo.r2['second'].length != 0) {
                    if (inInfo.r2['second']['prob'] > prob) {
                      car_num = inInfo.r2['second']['text'];
                    }
                  }
                }
                if (inInfo.r2['third'].length != 0) //파손 있을 때.
                {
                  for (int i = 0; i < inInfo.r2['third'].length; i++) {
                    inInfo.x.add(
                        inInfo.r2['third'][i]['mapping_point'][0] * 15 / 32);
                    inInfo.y.add(
                        inInfo.r2['third'][i]['mapping_point'][1] * 15 / 32 +
                            37.5);
                  }
                }
                inInfo.t2 = inInfo.r2['third'].length.toString() + " Defect(s)";
                errorMsg = '';
              }
              if (Frame.frame == 2) {
                inInfo.r3 = await detect_car(img64);
                if (inInfo.r3.containsKey('second')) {
                  if (inInfo.r3['second'].length != 0) {
                    if (inInfo.r3['second']['prob'] > prob) {
                      car_num = inInfo.r3['second']['text'];
                    }
                  }
                }
                if (inInfo.r3['third'].length != 0) //파손 있을 때.
                {
                  for (int i = 0; i < inInfo.r3['third'].length; i++) {
                    inInfo.x.add(
                        inInfo.r3['third'][i]['mapping_point'][0] * 15 / 32);
                    inInfo.y.add(
                        inInfo.r3['third'][i]['mapping_point'][1] * 15 / 32 +
                            37.5);
                  }
                }
                inInfo.t3 = inInfo.r3['third'].length.toString() + " Defect(s)";
                errorMsg = '';
              }
              if (Frame.frame == 3) {
                inInfo.r4 = await detect_car(img64);
                if (inInfo.r4.containsKey('second')) {
                  if (inInfo.r4['second'].length != 0) {
                    if (inInfo.r4['second']['prob'] > prob) {
                      car_num = inInfo.r4['second']['text'];
                    }
                  }
                }
                if (inInfo.r4['third'].length != 0) //파손 있을 때.
                {
                  for (int i = 0; i < inInfo.r4['third'].length; i++) {
                    inInfo.x.add(
                        inInfo.r4['third'][i]['mapping_point'][0] * 15 / 32);
                    inInfo.y.add(
                        inInfo.r4['third'][i]['mapping_point'][1] * 15 / 32 +
                            37.5);
                  }
                }
                inInfo.t4 = inInfo.r4['third'].length.toString() + " Defect(s)";
                errorMsg = '';

                inInfo.car_number = car_num; //제일 prob높은 car_num 넘겨줌
              }

              // print("path " + path);
              Frame.frame = Frame.frame + 1;
              int num = Frame.frame;
              String file_name = 'pic' + '$num';
              if (Frame.in_or_out == 'in') {
                In_Pic.Set(file_name, path);
              } else {
                Out_Pic.Set(file_name, path);
              }

              // In_Pic.Set(file_name, File(path));
              //사진 셋팅
              //4번 찍으면 화면 돌아가게 함.
              if (Frame.frame != 4) {
              } else {
                Frame.frame = 0;
                Navigator.pop(context);

                //잘 안돼!
                Navigator.pop(context);
                if (Frame.in_or_out == 'in') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => In(),
                    ),
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => Out(),
                    ),
                  );
                }
              }
            } catch (e) {
              // 만약 에러가 발생하면, 콘솔에 에러 로그를 남깁니다.
              List<String> errorList = ['전면', '오른쪽 측면', '후면', '왼쪽 측면'];

              errorMsg = errorList[Frame.frame] + " 사진을 다시 찍어주세요";

              print("ERROR!!!!!!!!!!!!!!!!!!!!!!!ERROR");
              print(e);
            }
            setState(() {
              if (Frame.frame == 1) {
                order = '오른쪽 측면을 찍어주세요';
              }
              if (Frame.frame == 2) {
                order = '후면을 찍어주세요';
              }
              if (Frame.frame == 3) {
                order = '왼쪽 측면을 찍어주세요';
              }
            });
          },
        ),
      ),
    );
  }
}

class CameraData {
  static String path1 = '';
  static String path2 = '';
  static String path3 = '';
  static String path4 = '';
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

void flutterToast() {
  Fluttertoast.showToast(
    msg: '4장의 사진을 모두 찍어야 돌아갈 수 있습니다.',
    gravity: ToastGravity.CENTER,
    backgroundColor: Colors.red,
    fontSize: 15.0,
    textColor: Colors.white,
    toastLength: Toast.LENGTH_SHORT,
  );
}
