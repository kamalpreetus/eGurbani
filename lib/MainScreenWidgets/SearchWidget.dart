import 'package:flutter/material.dart';
import 'package:floating_search_bar/floating_search_bar.dart';
import 'package:flutter/cupertino.dart';

class FloatingSearchWidget extends StatefulWidget {
  @override
  _FloatingSearchWidgetState createState() => _FloatingSearchWidgetState();
}

class _FloatingSearchWidgetState extends State<FloatingSearchWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      color: Colors.amber,
      child: FloatingSearchBar.builder(
        itemCount: 100,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text("Title"),
          );
        },
        trailing: new SearchSettingsWidget(), // should this be stateful?
        drawer: Drawer(
          child: Container(),
        ),
        onChanged: (String value) {},
        onTap: () {},
        decoration: InputDecoration.collapsed(
          hintText: "Search...",
        ),
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