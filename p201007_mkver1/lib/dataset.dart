import 'package:flutter/material.dart';

class MemberData {
  static String id = "null";
  static String com = "null";
}

class Cam {
  static var cam;
}

class Frame {
  static int frame = 0;
  static String in_or_out = '';
}

class In_Pic {
  static void Set(name, img) {
    if (name == 'pic1') {
      pic1 = img;
    } else if (name == 'pic2') {
      pic2 = img;
    } else if (name == 'pic3') {
      pic3 = img;
    } else if (name == 'pic4') {
      pic4 = img;
    }
  }

  static void Get(name) {
    if (name == 'pic1') {
      return pic1;
    } else if (name == 'pic2') {
      return pic2;
    } else if (name == 'pic3') {
      return pic3;
    } else if (name == 'pic4') {
      return pic4;
    }
  }

  static var pic1;
  static var pic2;
  static var pic3;
  static var pic4;
}

class Out_Pic {
  static void Set(name, img) {
    if (name == 'pic1') {
      pic1 = img;
    } else if (name == 'pic2') {
      pic2 = img;
    } else if (name == 'pic3') {
      pic3 = img;
    } else if (name == 'pic4') {
      pic4 = img;
    }
  }

  static void Get(name) {
    if (name == 'pic1') {
      return pic1;
    } else if (name == 'pic2') {
      return pic2;
    } else if (name == 'pic3') {
      return pic3;
    } else if (name == 'pic4') {
      return pic4;
    }
  }

  static var pic1;
  static var pic2;
  static var pic3;
  static var pic4;
}

class CameraData {
  static int whereIsIn = 0;
  static int whereIsOut = 0;
}

class inInfo {
  static String t1 = "";
  static String t2 = "";
  static String t3 = "";
  static String t4 = "";

  static var r1;
  static var r2;
  static var r3;
  static var r4;

  static String car_number = '-';
  static String car_kind = '-';
  static String consumer_name = '-';
  static String drived_distance = '-';
  static String fuel = '-';

  static List<double> x = [];
  static List<double> y = [];
  static List<Color> color_name = [];
  static List<double> size_dot = [];
  static int index;
}

class outInfo {
  static String t1 = "not yet";
  static String t2 = "not yet";
  static String t3 = "not yet";
  static String t4 = "not yet";

  static var r1;
  static var r2;
  static var r3;
  static var r4;

  static String car_number = '-';
  static String car_kind = '-';
  static String consumer_name = '-';
  static String drived_distance = '-';
  static String fuel = '-';

  static List<double> x = [];
  static List<double> y = [];
  static List<Color> color_name = [];
  static List<double> size_dot = [];
  static int index;
}

class Data {
  static List carList = [
    ['K5', '11허 1111', true, ""],
    ['AVANTE', '22허 2222', false, "요소수 주입\n엔진오일 교체"],
    ['K5', '33허 3333', false, "램프 교체"],
    ['AUDI', '43허 3123', true, ""],
  ];
  static Map<dynamic, dynamic> tasks;
}
