
import 'package:flutter/material.dart';

/// Search bar
class SearchBar extends StatelessWidget {
  const SearchBar({
    Key key,
    @required this.searchController,
  }) : super(key: key);

  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(fontFamily: 'OpenGurbaniAkharBlack', fontSize: 18.0),
      onChanged: (value) {},
      onTap: () {},
      controller: searchController,
      decoration: InputDecoration(
          labelText: "src gurbwnI",
          hintText: "Sbd dy pihly A`Kr ilKo",
          prefixIcon: Icon(Icons.search),
          suffixIcon: InkWell(
              borderRadius: BorderRadius.all(Radius.circular(25.0)),
              child: Icon(Icons.clear),
              onTap: () => searchController.clear()
          ),
          border: OutlineInputBorder( // NOT WORKING, WHY?
              borderRadius: BorderRadius.all(Radius.circular(30.0)
              ), borderSide: BorderSide( width: 5.5))),
    );
  }
}