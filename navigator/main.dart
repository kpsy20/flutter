import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Exercise',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FirstPage(),
    );
  }
}

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FirstPage') ,
        ),
      body: Center(
        child: RaisedButton(
          child: Text('Go to the Second Page'),
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(
              builder:(_){
                return SecondPage();
                }
              )
            );
          },
        )
      )
    );
  }
}

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('SecondPage') ,
        ),
        body: Center(
            child: RaisedButton(
              child: Text('Go to the First Page'),
              onPressed: (){
                Navigator.pop(context);
              },
            )
        )
    );
  }
}
