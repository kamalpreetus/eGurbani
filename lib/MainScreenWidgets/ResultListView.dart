import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter2/MainScreenWidgets/BaniWidget.dart';
import 'package:flutter2/Model/Bani/Banis.dart';
import 'package:flutter2/Model/QueryResult.dart';

/// Result list view on the search screen
class ResultListViewWidget extends StatelessWidget {
  const ResultListViewWidget({
    Key key,
    @required this.queryResultList,
    @required ScrollController listViewController,
  }) : _listViewController = listViewController, super(key: key);

  final Future<List<QueryResult>> queryResultList;
  final ScrollController _listViewController;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: queryResultList,
        builder: (BuildContext context, AsyncSnapshot snapshot) {

          if (snapshot.data == null) {
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          print("rebuilding KKKKK ");
          return ListView.builder(
            controller: _listViewController,
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () {
                  Navigator.push(context, CupertinoPageRoute(builder: (context) => BaniWidget(JapjiSahib())));
                },
                leading: CircleAvatar(),
                trailing: Text(snapshot.data[index].sourcePage.toString()),
                title: Text(snapshot.data[index].gurmukhi,
                    style: TextStyle(fontFamily: 'OpenGurbaniAkharBlack', fontSize: 20.0, wordSpacing: -7)),
              );
            },
          );
        }
    );
  }
}