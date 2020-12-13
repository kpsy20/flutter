import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'adManager.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        backgroundColor: Colors.black,
      ),
      home: GTX(),
    );
  }
}

class GTX extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FirebaseAdMob.instance.initialize(appId: AdManager.appId);

    MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
      keywords: <String>['subway', 'gtx', '지하철', '재개발', '재건축'],
      contentUrl: 'https://flutter.io',
      childDirected: false,
      testDevices: <String>[], // Android emulators are considered test devices
    );

    BannerAd myBanner = BannerAd(
      adUnitId: AdManager.bannerAdUnitId,
      size: AdSize.smartBanner,
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {
        print("BannerAd event is $event");
      },
    );

    myBanner
      ..load()
      ..show(
        anchorType: AnchorType.bottom,
      );
    return Scaffold(
      appBar: AppBar(
        title: Text("GTX 노선도"),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Center(
          // mainAxisAlignment: MainAxisAlignment.center,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AspectRatio(
                aspectRatio: 1 / 1,
                child: ClipRect(
                  child: PhotoView(
                    tightMode: true,
                    initialScale: 0.05,
                    minScale: 0.05,
                    maxScale: 1.25,
                    imageProvider: AssetImage('image/gtx2.png'),
                    backgroundDecoration: BoxDecoration(
                      color: Colors.transparent,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
              Text(
                "GTX-A",
                style: TextStyle(color: Colors.red, fontSize: 20),
              ),
              Text(
                "운정 - 킨텐스 - 대곡 \n연신내 - 서울역 - 삼성\n수서 - 성남 - 용인\n동탄",
                textAlign: TextAlign.center,
              ),
              Text(
                "\n(A노선) 삼성~동탄 39.5km, 1조 7,601억 원, ’14~’23년 \n 파주~삼성 46km, 2조 9,017억 원, ’17~’23년",
                textAlign: TextAlign.center,
              ),
              Text(
                "\nGTX-B",
                style: TextStyle(color: Colors.blue, fontSize: 20),
              ),
              Text(
                "송도 - 인천시청 - 부천종합운동장\n신도림 - 여의도 - 서울역\n청량리 - 망우 - 별내\n평내호평 - 마석",
                textAlign: TextAlign.center,
              ),
              Text(
                "\n(B노선) 송도~마석 80.1km, 5조 9,351억 원\n경춘선(망우~마석, 25.0km) 기존선 활용",
                textAlign: TextAlign.center,
              ),
              Text(
                "\nGTX-C",
                style: TextStyle(color: Colors.green, fontSize: 20),
              ),
              Text(
                "덕정 - 의정부 - 창동\n광운대 - 청량리 - 삼성\n양재 - 과천 - 금정\n수원",
                textAlign: TextAlign.center,
              ),
              Text(
                "\n(C노선) 덕정~수원 74.2km, 4조 3,088억 원\n경원선 덕정~도봉산(17.7km), 과천선 인덕원~금정(6.1km)경부선 금정~수원(14.0km) 기존선 활용",
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 300),
            ],
          ),
        ),
      ),
    );
  }
}
