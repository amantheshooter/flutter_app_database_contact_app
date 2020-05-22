import 'package:flutter/material.dart';
import 'package:flutterappdatabasenewsapp/textController.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Retrieve Text Input',
      home: MyCustomForm(),
    );
  }
}
