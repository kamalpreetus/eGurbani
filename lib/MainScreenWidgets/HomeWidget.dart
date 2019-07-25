import 'package:flutter/material.dart';

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
    return FloatingSearchWidget();
  }

  Widget searchField() {
    return TextField(
      autofocus: true,
      decoration: InputDecoration(
          hintText: "search",
          prefixIcon: Icon(Icons.search),
          suffixIcon: IconButton(
            icon: Icon(Icons.close),
            onPressed: (){
              print("cancel");
            },
          ),
          fillColor: Colors.white,
          filled: true),
    );
  }

  void onChangedText() {
    print("Text changed\n");
  }
}