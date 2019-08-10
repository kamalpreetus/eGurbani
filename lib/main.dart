import 'package:flutter/material.dart';
import 'MainScreenWidgets/HomeWidget.dart';
import 'package:flutter2/Model/databaseReader.dart';

import 'Model/Choices.dart';
import 'Model/QueryResult.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    DatabaseReader db = new DatabaseReader();
    Future<List<QueryResult>> l = db.runQuery(Choices.FirstLetterStart, "qpddmp");

    return MaterialApp(
      title: 'eGurbani',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // the home is typically a Scaffold
      home: HomePageWidget(title: 'eGurbani Home Page'),
    );
  }
}