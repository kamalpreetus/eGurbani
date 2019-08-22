import 'package:flutter/material.dart';
import 'package:flutter2/MainScreenWidgets/BaniWidget.dart';
import 'package:flutter2/Model/Choices.dart';
import 'package:flutter2/Model/QueryResult.dart';
import 'package:flutter2/Model/databaseReader.dart';

class NitnemWidget extends StatelessWidget {
  final Color color;
  List<String> banis = ["Japji Sahib", "Rehras Sahib"];

  NitnemWidget(this.color);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Nitnem")
      ),
      body: Container(
        child: _listOfBanis(context),
      ),
    );
  }

  // replace this function with the code in the examples
  Widget _listOfBanis(BuildContext context) {
    return ListView.builder(
        itemCount: banis.length,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () => {
              Navigator.push(context,
              MaterialPageRoute(builder: (context) => BaniWidget(index)))
            },
            title: Text(banis[index], style: TextStyle(fontSize: 20.0),),
            trailing: Icon(Icons.keyboard_arrow_right),
          );
        }
    );
  }
}