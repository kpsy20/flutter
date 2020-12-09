import 'dart:async';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'main.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> main() async {
  //카메라 찾는부분, 정확히 어떤 기능을 수행하는지는 모름..
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  final firstCamera = cameras.first;
  Cam.cam = firstCamera;
  runApp(Camera());
}

class Cam {
  static var cam;
}

class Camera extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Pic());
  }
}

class Pic extends StatefulWidget {
  final CameraDescription camera = Cam.cam;

  @override
  _PicState createState() => _PicState();
}

class _PicState extends State<Pic> {
  CameraController _controller;
  Future<void> _initializeControllerFuture;

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
    return Scaffold(
      body: Container(
        child: FutureBuilder<void>(
          future: _initializeControllerFuture,
          builder: (context, snapshot) {
            // final size = MediaQuery.of(context).size;
            // final deviceRatio = size.width / size.height;
            return snapshot.connectionState != ConnectionState.done
                ? Center(child: CircularProgressIndicator())
                : CameraData.whereIs == 0
                    ? CameraPreview(
                        _controller,
                      )
                    : Center(child: CircularProgressIndicator());
          },
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton(
            onPressed: () {
              CameraData.whereIs = 1;
              setState(() {});
            },
            child: Icon(Icons.add_shopping_cart),
          ),
          FloatingActionButton(
            onPressed: () {
              CameraData.whereIs = 0;
              setState(() {});
            },
            child: Icon(Icons.camera),
          ),
        ],
      ),
    );
  }
}

class CameraData {
  static int whereIs = 0;
}
