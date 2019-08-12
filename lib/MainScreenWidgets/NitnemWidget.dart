import 'package:flutter/material.dart';
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

class BaniWidget extends StatefulWidget {

  int baniId;
  BaniWidget(this.baniId);
  Future<List<QueryResult>> queryResultList;


  @override
  State<StatefulWidget> createState() => BaniWidgetState();

}

class BaniWidgetState extends State<BaniWidget> {
  DatabaseReader db = new DatabaseReader();

  @override
  void initState() {
    super.initState();
    this.widget.queryResultList = db.runQuery(Choices.Bani, "7");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Bani Title"),
        ),
        body: FutureBuilder(
          future: this.widget.queryResultList,
          builder: (BuildContext context, AsyncSnapshot snapshot) {

            if (snapshot.data == null) {
              return Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }

            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(snapshot.data[index].gurmukhi, style: TextStyle(fontFamily: 'WebAkharThick', fontSize: 20.0)),
                );
              },
            );
          }
        )
    );
  }

}