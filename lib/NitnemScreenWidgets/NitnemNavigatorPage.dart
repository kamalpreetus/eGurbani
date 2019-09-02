import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter2/MainScreenWidgets/BaniWidget.dart';
import 'package:flutter2/Model/Bani/Banis.dart';
import 'package:flutter2/Model/Bani/IBani.dart';
import 'package:flutter2/Model/Choices.dart';
import 'package:flutter2/Model/QueryResult.dart';
import 'package:flutter2/Model/databaseReader.dart';

class NitnemNavigatorPage extends StatefulWidget {
  NitnemNavigatorPage({ Key key, this.child }) : super(key: key);

  final Widget child;
  List<String> banis = ["Japji Sahib", "Rehras Sahib"];

  @override
  _NitnemNavigatorPageState createState() => _NitnemNavigatorPageState();
}

class _NitnemNavigatorPageState extends State<NitnemNavigatorPage> {
  TextEditingController _textController;
  Future<List<QueryResult>> queryResultList;

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
    queryResultList = DatabaseReader().runQuery(Choices.Bani, "7");
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (RouteSettings settings) {
        return new CupertinoPageRoute(
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
                          return new BaniTile(banis: banis, index: index);
                        }
                     ),
                  )
                ],
              ),
            );
          },
        );
      },
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