import 'package:flutter/material.dart';
import 'MainScreenWidgets/HomeWidget.dart';
import 'databasereader.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    DatabaseReader db = new DatabaseReader();
    db.runQuery();

    return MaterialApp(
      title: 'eGurbani',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePageWidget(title: 'eGurbani Home Page'),
    );
  }
}