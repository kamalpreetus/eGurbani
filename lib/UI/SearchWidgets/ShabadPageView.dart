import 'package:flutter/material.dart';
import 'package:flutter2/Model/Shabad/ShabadFinder.dart';

class ShabadPageView extends StatefulWidget {

  String shabadID;
  ShabadPageView(this.shabadID);

  @override
  State createState() => new ShabadList();
}
class ShabadList extends State<ShabadPageView> {
  @override
  Widget build (BuildContext ctxt) {

    ShabadFinder shabadFinder = new ShabadFinder();
    shabadFinder.generateShabadLine(this.widget.shabadID);

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