
// another class
import 'package:flutter/material.dart';

import '../../SharedPrefHelper.dart';

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
          padding: const EdgeInsets.only(left: 25.0),
          child: SizedBox(
            width: 80,
            child: Text(
                this.widget.title,
                style: TextStyle(
                    fontSize: 17.0)),
          ),
        ),
        FutureBuilder<String> (
          future: SharedPrefHelper.getValue(this.widget.title),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {

            if (snapshot.data == null) {
              return SizedBox(
                width: 200,
                child: Text("Loading"),
              );
            }

            return SizedBox(
                width: 220,
                child: ButtonTheme(
                  alignedDropdown: true,
                  child: new DropdownButton<String>(
                      isExpanded: true,
                      hint: Text(snapshot.data, style: TextStyle(color: Colors.black),), // default value - Get from shared prefs
                      onChanged: (String changedValue) {
                        setState(() {
                          selectedValue=changedValue;
                          SharedPrefHelper.setValue(this.widget.title, changedValue);
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
              );
          },
        )
      ],
    );
  }

}