import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter2/Model/Bani/Banis.dart';
import 'package:flutter2/Model/Bani/IBani.dart';
import 'package:flutter2/Model/QueryChoices.dart';
import 'package:flutter2/Model/QueryResult.dart';
import 'package:flutter2/Model/databaseReader.dart';
import 'package:flutter2/UI/NitnemWidgets/BaniWidget.dart';

/// List of banis widget
class BaniList extends StatefulWidget {
  BaniList({ Key key, this.child }) : super(key: key);

  final Widget child;
  List<String> banis = ["Japji Sahib", "Rehras Sahib"];

  @override
  _BaniListState createState() => _BaniListState();
}

class _BaniListState extends State<BaniList> {
  TextEditingController _textController;
  List<IBani> banis;

  @override
  void initState() {
    super.initState();

    banis = [
      JapjiSahib(),
      JaapSahib(),
      TavPrasadSavaiye(),
      ChaupaiSahib(),
      AnandSahib(),
      RehrasSahib(),
      SohilaSahib(),
      SukhmaniSahib()
    ];

    _textController = TextEditingController(
      text: 'sample text: ${widget.child}',
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("Nitnem")
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Expanded(
            child: ListView.builder(
                itemCount: banis.length,
                itemBuilder: (context, index) {
                  return new BaniTile(banis: banis, index: index);
                }
             ),
          )
        ],
      ),
    );
  }
}

/// This is what gets loaded when a user clicks on a Bani
class BaniTile extends StatelessWidget {
  int index;
  BaniTile({
    Key key,
    @required this.banis,
    @required this.index,
  }) : super(key: key);

  final List<IBani> banis;

  @override
  Widget build(BuildContext context) {

    return ListTile(
      onTap: () {
        Navigator.push(context, CupertinoPageRoute(builder: (context) => BaniWidget(banis[index])));
      },
      title: Text(banis[index].name(), style: TextStyle(fontSize: 20.0)),
      trailing: Icon(Icons.keyboard_arrow_right),
    );
  }
}