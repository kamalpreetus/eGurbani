import 'package:flutter/material.dart';

class ShabadPageView extends StatefulWidget {

  int shabadID;
  ShabadPageView(this.shabadID);

  @override
  State createState() => new ShabadList();
}
class ShabadList extends State<ShabadPageView> {
  @override
  Widget build (BuildContext ctxt) {
    return new Scaffold(
      body: new Column(
        children: <Widget>[
          new Expanded(
              child: new ListView.builder(
                  itemCount: 3, // number of lines of a shabad
                  itemBuilder: (BuildContext ctxt, int Index) {
                    return new Text("Shabad...");
                  }
                  )
          )
        ],
      ),
    );
  }
}