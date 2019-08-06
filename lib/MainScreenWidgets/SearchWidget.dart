import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter2/Model/Choices.dart';
import 'package:flutter2/Model/databaseReader.dart';

import 'Dialogs/CustomSimpleDialog.dart';

/// search widget + filter button on the search screen
class FloatingSearchWidget extends StatefulWidget {
  @override
  _FloatingSearchWidgetState createState() => _FloatingSearchWidgetState();
}

class _FloatingSearchWidgetState extends State<FloatingSearchWidget> {
  final searchController = TextEditingController();
  bool checkboxValueCity = false;
  List<String> allCities = ['Alpha', 'Beta', 'Gamma'];
  List<String> selectedCities = [];

  @override
  void initState() {
    super.initState();

    searchController.addListener(_printLatestValue);
    // add listener to update listview
//    searchController.addListener(_updateListView);
  }

  void _printLatestValue() {
    print("Second text field: ${searchController.text}");
  }


  openFilterDialog(BuildContext context) {
    print("Filter button clicked");

  }

  @override
  Widget build(BuildContext context) {

    DatabaseReader db = new DatabaseReader();

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
                  ), borderSide: BorderSide(color: Colors.blueAccent, width: 5.5))),
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
            future: db.runQuery(Choices.FirstLetterStart),
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

