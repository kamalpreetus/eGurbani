import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter2/Model/Bani/IBani.dart';
import 'package:flutter2/Model/Choices.dart';
import 'package:flutter2/Model/QueryResult.dart';
import 'package:flutter2/Model/databaseReader.dart';

/// Bani page. this is where banis show up when a list item (bani) is clicked
class BaniWidget extends StatefulWidget {

  IBani bani;
  BaniWidget(this.bani);
  Future<List<QueryResult>> queryResultList;

  @override
  State<StatefulWidget> createState() => BaniWidgetState();

}

class BaniWidgetState extends State<BaniWidget> {
  DatabaseReader db = new DatabaseReader();
  bool _isAppbar = true;
  ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        appBarStatus(false);
      }
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        appBarStatus(true);
      }
    });

    this.widget.queryResultList = db.runQuery(Choices.Bani, this.widget.bani.id().toString());
  }

  /// Helper function for hiding appbar on scroll
  /// This is a hack, alternative solution is to use
  /// a CustomScrollView but making FutureBuilder work with
  /// it is not easy.
  void appBarStatus(bool status) {
    setState(() {
      _isAppbar = status;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight ),
          child: AnimatedContainer(
            height: _isAppbar ? kToolbarHeight  + 25.0 : 0.0,
            duration: Duration(milliseconds: 200),
            child: CustomAppBar(),
          ),
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
                controller: _scrollController,
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

class CustomAppBar extends StatefulWidget {
@override
AppBarView createState() => new AppBarView();
}

class AppBarView extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text("AppBar"),
    );
  }
}