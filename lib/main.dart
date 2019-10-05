import 'package:flutter/material.dart';
import 'package:flutter2/UI/Tabbed.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'eGurbani',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      // the home is typically a Scaffold
      home: Tabbed(),
    );
  }
}