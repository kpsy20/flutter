import 'mainpage.dart';
import 'main.dart';
import 'package:flutter/material.dart';

class Task extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Text(
            '업무리스트',
            style: TextStyle(fontSize: 200),
          ),
        ),
      ),
    );
  }
}
