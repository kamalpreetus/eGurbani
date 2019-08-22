import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter2/MainScreenWidgets/BaniWidget.dart';
import 'package:flutter2/Model/Choices.dart';
import 'package:flutter2/Model/QueryResult.dart';
import 'package:flutter2/Model/databaseReader.dart';

import 'EnterExitTransition.dart';
import 'NitnemWidget.dart';

class NavigatorPage extends StatefulWidget {
  NavigatorPage({ Key key, this.child }) : super(key: key);

  final Widget child;
  List<String> banis = ["Japji Sahib", "Rehras Sahib"];

  @override
  _NavigatorPageState createState() => _NavigatorPageState();
}

class _NavigatorPageState extends State<NavigatorPage> {
  TextEditingController _textController;
  Future<List<QueryResult>> queryResultList;
  List<String> banis = ["Japji Sahib", "Rehras Sahib"];

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(
      text: 'sample text: ${widget.child}',
    );
    queryResultList = DatabaseReader().runQuery(Choices.Bani, "7");
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (RouteSettings settings) {
        return new MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) {
            return Scaffold(
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
                          return ListTile(
                            onTap: () {
                              Navigator.push(context, CupertinoPageRoute(builder: (context) => BaniWidget(index)));
                            },
                            title: Text(banis[index], style: TextStyle(fontSize: 20.0)),
                            trailing: Icon(Icons.keyboard_arrow_right),
                          );
                        }
                     ),
                  )
                  ,
                ],
              ),
            );
          },
        );
      },
    );
  }
}