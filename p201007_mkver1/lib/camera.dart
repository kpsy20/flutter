import 'dart:async';
import 'dart:io';
import 'main.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';

import 'package:fluttertoast/fluttertoast.dart';
// Future<void> main2() async {
//   // 디바이스에서 이용가능한 카메라 목록을 받아옵니다.
//   WidgetsFlutterBinding.ensureInitialized();
//   final cameras = await availableCameras();

//   // 이용가능한 카메라 목록에서 특정 카메라를 얻습니다.
//   final firstCamera = cameras.first;

//   runApp(
//     MaterialApp(
//       theme: ThemeData.dark(),
//       home: Camera4(
//         // 적절한 카메라를 TakePictureScreen 위젯에게 전달합니다.
//         camera: firstCamera,
//       ),
//     ),
//   );
// }

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
  CameraController _controller;
  Future<void> _initializeControllerFuture;

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
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  '4장의 사진을 모두 찍어야 돌아갈 수 있습니다.',
                  textAlign: TextAlign.center,
                ),
              ),
            );
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

        body: FutureBuilder<void>(
          future: _initializeControllerFuture,
          builder: (context, snapshot) {
            final size = MediaQuery.of(context).size;
            final deviceRatio = size.width / size.height;

            if (snapshot.connectionState == ConnectionState.done) {
              // Future가 완료되면, 프리뷰를 보여줍니다.
              return CameraPreview(_controller);
            } else {
              // 그렇지 않다면, 진행 표시기를 보여줍니다.
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.camera_alt),
          // onPressed 콜백을 제공합니다.
          onPressed: () async {
            try {
              // 카메라 초기화가 완료됐는지 확인합니다.

              await _initializeControllerFuture;

              // path 패키지를 사용하여 이미지가 저장될 경로를 지정합니다.
              final path = join(
                // 본 예제에서는 임시 디렉토리에 이미지를 저장합니다. `path_provider`
                // 플러그인을 사용하여 임시 디렉토리를 찾으세요.
                (await getTemporaryDirectory()).path,
                '${DateTime.now()}.png',
              );

              // 사진 촬영을 시도하고 저장되는 경로를 로그로 남깁니다.
              await _controller.takePicture(path);
              // 사진을 촬영하면, 새로운 화면으로 넘어갑니다.
              Frame.frame = Frame.frame + 1;
              if (Frame.frame != 4) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Camera4(),
                    // builder: (context) => DisplayPictureScreen(imagePath: path),
                  ),
                );
              } else {
                Frame.frame = 0;
                Navigator.pop(context);
                Navigator.pop(context);
                Navigator.pop(context);
                Navigator.pop(context);
              }
            } catch (e) {
              // 만약 에러가 발생하면, 콘솔에 에러 로그를 남깁니다.
              print(e);
            }
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
      appBar: AppBar(title: Text('Display the Picture')),
      // 이미지는 디바이스에 파일로 저장됩니다. 이미지를 보여주기 위해 주어진
      // 경로로 `Image.file`을 생성하세요.
      body: Image.file(File(imagePath)),
    );
  }
}

// void flutterToast() {
//   Fluttertoast.showToast(
//     msg: '4장의 사진을 모두 찍어야 돌아갈 수 있습니다.',
//     gravity: ToastGravity.TOP,
//     backgroundColor: Colors.teal,
//     fontSize: 20.0,
//     textColor: Colors.white,
//     toastLength: Toast.LENGTH_SHORT,
//   );
// }
