
// another class
import 'package:flutter/material.dart';

class FilterTile extends StatefulWidget {

  FilterTile(this.title, this.list);

  String title;
  List<String> list;
  @override
  State<StatefulWidget> createState() => FilterTileState();
}


class FilterTileState extends State<FilterTile> {
  String selectedValue;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
              this.widget.title,
              style: TextStyle(
                  fontSize: 17.0)),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 40.0),
          child: SizedBox(
            width: 200,
            child: ButtonTheme(
              alignedDropdown: true,
              child: new DropdownButton<String>(
                  isExpanded: true,
                  hint: Text('Choose'), // default value - Get from shared prefs
                  onChanged: (String changedValue) {
                    selectedValue=changedValue;
                    setState(() {
                      selectedValue;
                      print(selectedValue);
                    });
                  },
                  value: selectedValue,
                  items: this.widget.list.map((String value) {
                    return new DropdownMenuItem<String>(
                      value: value,
                      child: new Text(value),
                    );
                  }).toList()),
            ),
          ),
        )
      ],
    );
  }

}