import 'package:flutter/material.dart';
import 'file:///D:/Flutter%20Projects/flutter_app_database_news_app/lib/ui/textController.dart';

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
