import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter2/Model/Choices.dart';
import 'package:flutter2/Model/QueryResult.dart';
import 'package:flutter2/Model/databaseReader.dart';

import 'Dialogs/CustomSimpleDialog.dart';

/// search widget + filter button on the search screen
class FloatingSearchWidget extends StatefulWidget {
  @override
  _FloatingSearchWidgetState createState() => _FloatingSearchWidgetState();
}

class _FloatingSearchWidgetState extends State<FloatingSearchWidget> {
  DatabaseReader db = new DatabaseReader();
  final searchController = TextEditingController();
  ScrollController _listViewController = ScrollController();
  bool checkboxValueCity = false;
  List<String> allCities = ['Alpha', 'Beta', 'Gamma'];
  List<String> selectedCities = [];
  Future<List<QueryResult>> items2;

  @override
  void initState() {
    super.initState();
    items2 = db.runQuery(Choices.FirstLetterStart, "qddqdK");
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
    if (size > 3) {
        setState(() {
          print("text size is $size");
          items2 = db.runQuery(Choices.FirstLetterStart, searchController.text);
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
              return CustomSimpleDialog(
                  cities: allCities,
                  selectedCities: selectedCities,
                  onSelectedCitiesListChanged: (cities) {
                    selectedCities = cities;
                    print(selectedCities);
                  });
            }
          ),
          child: Container(
            child: Icon(
              Icons.filter_list,
              color: Colors.black,
              size: 60.0,
            ),
            decoration: new BoxDecoration(
                border: new Border.all(color: Colors.black, width: 2.0),
                borderRadius: BorderRadius.all(Radius.circular(25.0))
            ) ,
          ),
        ),
      ),
      Flexible(
        child: TextField(
          onChanged: (value) {},
          onTap: () {},
          controller: searchController,
          decoration: InputDecoration(
              labelText: "Search",
              hintText: "Search",
              prefixIcon: Icon(Icons.search),
              suffixIcon: InkWell(
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
                child: Icon(Icons.clear),
                  onTap: () => searchController.clear()
              ),
              border: OutlineInputBorder( // NOT WORKING, WHY?
                  borderRadius: BorderRadius.all(Radius.circular(30.0)
                  ), borderSide: BorderSide(color: Colors.black, width: 5.5))),
        ),
      ),
    ];

    List<Widget> mainScreenChildren = [
      Padding(
        padding: const EdgeInsets.only(top: 25.0, bottom: 5.0),
        child: Row(
            children: searchBarChildren
        ),
      ),
      Expanded(
        child: FutureBuilder(
            future: items2,
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
                    title: Text(snapshot.data[index].gurmukhi, style: TextStyle(fontFamily: 'GurmukhiWebThick')),
                  );
                },
              );
            }
        ),
      ),
    ];

    return Container(
      padding: EdgeInsets.all(10),
      //color: Colors.amber,
      child: Column(
        children: mainScreenChildren,
      ),
    );
  }
}

