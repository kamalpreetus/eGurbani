import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter2/Model/Bani/IBani.dart';
import 'package:flutter2/Model/QueryChoices.dart';
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
  bool _enableAutoScroll = false;
  bool enableLareevar = false;
  ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    super.initState();

//    _scrollController.addListener(() {
//      if ((_scrollController.position.userScrollDirection ==
//          ScrollDirection.reverse || _scrollController.position.userScrollDirection ==
//          ScrollDirection.forward) && _enableAutoScroll) {
//
//        // wait for the user to finish scrolling
//        while(_scrollController.position.userScrollDirection != ScrollDirection.idle) {
//          _scrollController.animateTo(
//            _scrollController.position.maxScrollExtent,
//            curve: Curves.linear,
//            duration: const Duration(minutes: 21),
//          );
//        }
//      }
//    });

    this.widget.queryResultList = db.runQuery(QueryChoices.Bani, this.widget.bani.id().toString());
  }

  /// Helper function for hiding appbar on scroll
  /// This is a hack, alternative solution is to use
  /// a CustomScrollView but making FutureBuilder work with
  /// it is not easy.
  void setAutoScrollStatus(bool status) {
    setState(() {
      _enableAutoScroll = status;
      enableLareevar = status;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: new FloatingActionButton(
          child: new Icon(Icons.arrow_downward),
          onPressed: () {
            setState(() {
              enableLareevar = !enableLareevar;
              _enableAutoScroll = true;
            });

//            if (_enableAutoScroll) {
//              _scrollController.animateTo(
//                _scrollController.position.maxScrollExtent,
//                curve: Curves.linear,
//                duration: const Duration(minutes: 1),
//              );
//            }

          },
        ),
        body: FutureBuilder(
            future: this.widget.queryResultList,
            builder: (BuildContext context, AsyncSnapshot snapshot) {

              if (!snapshot.hasData) {
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


                List<InlineSpan> _children = <TextSpan>[
                  new TextSpan(text: this.widget.bani.headingInGurmukhi(), style: TextStyle(fontFamily: 'OpenGurbaniAkharBlack', fontSize: 50.0)),
                  new TextSpan(text: "\n☬\t\t❀\t\t☬\n\n" + baniText.toString().replaceAll(new RegExp(r'[,.;]+'), "") + "\n\n☬\t\t❀\t\t☬", style: TextStyle(fontFamily: 'OpenGurbaniAkharBlack', fontSize: 25.0, wordSpacing: enableLareevar ? -8.5 : 0)),
                ];


                // this is what allos
                return CustomScrollView(
                  controller: _scrollController,
                  slivers: <Widget>[

                    SliverAppBar(
                      title: Text(this.widget.bani.name()),
                      floating: true,
                    ),

                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                return ListTile(
                                  title: new RichText(
                                    textAlign: TextAlign.center,
                                    text: new TextSpan(
                                      // Note: Styles for TextSpans must be explicitly defined.
                                      // Child text spans will inherit styles from parent
                                      style: DefaultTextStyle.of(context).style,
                                      children: _children,
                                    ),
                                  ),
                                );
                                },
                              childCount: 1
                      ),
                    ),
                  ],
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