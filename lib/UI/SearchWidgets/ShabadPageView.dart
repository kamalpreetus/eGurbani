import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter2/Model/Shabad/ShabadFinder.dart';
import 'package:flutter2/Model/Shabad/ShabadLine/IShabadLine.dart';

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
    Future<List<IShabadLine>> shabadLines = shabadFinder.generateShabadLine(this.widget.shabadID);

    return FutureBuilder(
        future: shabadLines,
        builder: (BuildContext context, AsyncSnapshot snapshot) {

          if (snapshot.data == null) {
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          print("rebuilding SSSS ");
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () {
                  Navigator.push(context, CupertinoPageRoute(builder: (context) => ShabadPageView(/* shabadId */ snapshot.data[index].shabadID)));
                },
                title: Text(snapshot.data[index].gurmukhiShabad,
                    style: TextStyle(fontFamily: 'OpenGurbaniAkharBlack', fontSize: 20.0, wordSpacing: -7)),
              );
            },
          );
        }
    );
  }
}