import 'package:flutter/material.dart';
import 'package:floating_search_bar/floating_search_bar.dart';
import 'package:flutter/cupertino.dart';

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
    return Container(
      padding: EdgeInsets.all(10),
      //color: Colors.amber,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 25.0),
            child: Row(
              children: <Widget>[
                Container(
                  child: Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.black,
                    size: 60.0,
                  ),
                  decoration: new BoxDecoration(
                    border: new Border.all(color: Colors.blueAccent, width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(30.0))
                  ) ,
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
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: 60,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('List tile'),
                );
              },
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