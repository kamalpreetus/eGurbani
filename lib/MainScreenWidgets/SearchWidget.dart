import 'package:flutter/material.dart';
import 'package:floating_search_bar/floating_search_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter2/Model/Choices.dart';
import 'package:flutter2/Model/databaseReader.dart';

class FloatingSearchWidget extends StatefulWidget {
  @override
  _FloatingSearchWidgetState createState() => _FloatingSearchWidgetState();
}

class _FloatingSearchWidgetState extends State<FloatingSearchWidget> {
  final searchController = TextEditingController();

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

  @override
  Widget build(BuildContext context) {

    DatabaseReader db = new DatabaseReader();

    return Container(
      padding: EdgeInsets.all(10),
      //color: Colors.amber,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 25.0, bottom: 5.0),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
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
                Flexible(
                  child: TextField(
                    onChanged: (value) {},
                    onTap: () {},
                    controller: searchController,
                    decoration: InputDecoration(
                        labelText: "Search",
                        hintText: "Search",
                        prefixIcon: Icon(Icons.search),
                        suffixIcon: IconButton(icon: Icon(Icons.clear), onPressed: () => searchController.clear()),
                        border: OutlineInputBorder( // NOT WORKING, WHY?
                            borderRadius: BorderRadius.all(Radius.circular(30.0)), borderSide: BorderSide(color: Colors.blueAccent, width: 5.5))),
                  ),
                ),
              ],
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
        ],
      ),
    );
  }
}

class SearchSettingsWidget extends StatelessWidget {
  const SearchSettingsWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      child: InkWell(
        child: Icon(
            CupertinoIcons.settings_solid,
            color: Colors.black,
            size: 40.0,
        ),
        onTap: () => print("CircleAvatar onTap"),
      ),
      backgroundColor: Colors.transparent,
    );
  }

}