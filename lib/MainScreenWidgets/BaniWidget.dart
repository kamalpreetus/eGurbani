import 'package:flutter/material.dart';
import 'package:flutter2/Model/Bani/IBani.dart';
import 'package:flutter2/Model/Choices.dart';
import 'package:flutter2/Model/QueryResult.dart';
import 'package:flutter2/Model/databaseReader.dart';

class BaniWidget extends StatefulWidget {

  IBani bani;
  BaniWidget(this.bani);
  Future<List<QueryResult>> queryResultList;

  @override
  State<StatefulWidget> createState() => BaniWidgetState();

}

class BaniWidgetState extends State<BaniWidget> {
  DatabaseReader db = new DatabaseReader();

  @override
  void initState() {
    super.initState();
    this.widget.queryResultList = db.runQuery(Choices.Bani, this.widget.bani.id().toString());
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

              StringBuffer baniText = new StringBuffer();

              for (int i = 0; i < snapshot.data.length; i++) {
                baniText.write(snapshot.data[i].gurmukhi);
              }

              return ListView.builder(
                itemCount: 1,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: new RichText(
                      textAlign: TextAlign.center,
                      text: new TextSpan(
                        // Note: Styles for TextSpans must be explicitly defined.
                        // Child text spans will inherit styles from parent
                        style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          new TextSpan(text: this.widget.bani.headingInGurmukhi(), style: TextStyle(fontFamily: 'WebAkharThick', fontSize: 50.0)),
                          new TextSpan(text: "\n☬\t\t❀\t\t☬\n\n" + baniText.toString().replaceAll(new RegExp(r'[,.;]+'), "") + "\n\n☬\t\t❀\t\t☬", style: TextStyle(fontFamily: 'WebAkharThick', fontSize: 25.0, wordSpacing: -8.5)),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
        )
    );
  }
}