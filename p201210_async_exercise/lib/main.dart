import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AsyncEx(),
    );
  }
}

class AsyncEx extends StatelessWidget {
  final List<String> entries = <String>['A', 'B', 'C'];
  final List<int> colorCodes = <int>[600, 500, 100];
  final List<Future<void> Function()> func = <Future<void> Function()>[a, b, c];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("async test")),
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: entries.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: 50,
            color: Colors.amber[colorCodes[index]],
            child: Center(
              child: FlatButton(
                onPressed: () {
                  func[index]();
                },
                child: Text(entries[index]),
              ),
            ),
          );
        },
      ),
    );
  }
}

Future<File> getImageFileFromAssets(String path) async {
  final byteData = await rootBundle.load('$path');

  final file = File((await getTemporaryDirectory()).path + '/$path');
  await file.writeAsBytes(byteData.buffer
      .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

  return file;
}

Future<void> a() async {
  print("Start A");
  i();
  print("Finish A");
}

Future<void> b() async {
  print("Start B");
  await img();
  print("Finish B");
}

Future<void> c() async {
  print("Start C");
  sleep(Duration(seconds: 4));
  print("Finish C");
}

Future i() async {
  for (int i = 0; i < 100; i++) {
    print(i.toString());
  }
}

Future img() async {
  File f = await getImageFileFromAssets('image/20201123_112041-2.jpg');
  final bytes = f.readAsBytesSync();
  String img64 = base64Encode(bytes);
  Map<String, String> param_dict = {"base64_image": img64};
  Map<String, String> headers = {"Content-type": "application/json"};
  final msg = jsonEncode(param_dict);
  //서버로 요청 보냄
  final response = await http.post("http://ai.nextlab.co.kr:9066/detect_car",
      headers: headers, body: msg);
  return response;
}
