import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter2/UI/SearchWidgets/Dialogs/FilterDialog.dart';
import 'package:flutter2/UI/SearchWidgets/SearchBar.dart';
import 'package:flutter2/Model/QueryChoices.dart';
import 'package:flutter2/Model/QueryResult.dart';
import 'package:flutter2/Model/databaseReader.dart';
import 'package:flutter2/UI/SearchWidgets/ResultListView.dart';

/// search widget + filter button on the search screen
class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  DatabaseReader db = new DatabaseReader();
  final searchController = TextEditingController();
  ScrollController _listViewController = ScrollController();
  List<String> selectedOption = [];
  Future<List<QueryResult>> queryResultList;

  @override
  void initState() {
    super.initState();
    queryResultList = db.runQuery(QueryChoices.FirstLetterStart, "qddqdK");
    _listViewController.addListener(_scrollListener);
    searchController.addListener(filterListview);
  }

  /// Hides keyboard when results listview is being scrolled
  void _scrollListener() {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  /// Filters listview as query is being in search field
  void filterListview() {
    print("Second text field: ${searchController.text}");

    int size = searchController.text.length;
    if (size > 2) {
        setState(() {
          print("text size is $size");
          queryResultList = db.runQuery(QueryChoices.FirstLetterStart, searchController.text);
        });
    }
  }

  openFilterDialog(BuildContext context) {
    print("Filter button clicked");
  }

  @override
  Widget build(BuildContext context) {

    // search bar and dialog filter button
    List<Widget> searchBarChildren = [
      Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: InkWell(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
          onTap: () => showDialog(
            context: context,
            builder: (context) {
              return FilterDialog(
                  onModeOptionsChanged: (modeOption) {
                    selectedOption = modeOption;
                    print(selectedOption);
                  });
            }
          ),
          child: Container(
            child: Icon(
              Icons.filter_list,
              color: Colors.black,
              size: 58.0
            ),
            decoration: new BoxDecoration(
                border: new Border.all(width: 2.0),
                borderRadius: BorderRadius.all(Radius.circular(25.0))
            ) ,
          ),
        ),
      ),
      Flexible(
        child: new SearchBar(searchController: searchController),
      ),
    ];

    List<Widget> mainScreenChildren = [
      Padding(
        padding: const EdgeInsets.only(top: 0.0, bottom: 5.0),
        child: Row(
            children: searchBarChildren
        ),
      ),
      Expanded(
        child: new ResultListViewWidget(
            queryResultList: queryResultList,
            listViewController: _listViewController
        ),
      ),
    ];

    return Container(
      padding: EdgeInsets.only(top: 25),
      child: Column(
          mainAxisSize: MainAxisSize.min,
          children: mainScreenChildren,
        )
    );

  }
}



