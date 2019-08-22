import 'package:flutter/material.dart';
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

          return ListView.builder(
            controller: _listViewController,
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: CircleAvatar(),
                trailing: Text(snapshot.data[index].sourcePage.toString()),
                title: Text(snapshot.data[index].gurmukhi.toString().replaceAll(new RegExp(r'[\s,;]+'), ""), style: TextStyle(fontFamily: 'WebAkharThick', fontSize: 20.0)),
              );
            },
          );
        }
    );
  }
}