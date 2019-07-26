import 'package:flutter/material.dart';

import 'BottomNavigationBarWidget.dart';
import 'SearchWidget.dart';

class HomePageWidget extends StatefulWidget {
  HomePageWidget({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FloatingSearchWidget(),
      bottomNavigationBar: new BottomNavigationBarWidget(),
    );
  }
}


