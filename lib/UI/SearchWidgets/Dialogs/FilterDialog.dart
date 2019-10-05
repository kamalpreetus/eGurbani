
import 'package:flutter/material.dart';

import 'package:flutter2/UI/SearchWidgets/Dialogs/FilterTile.dart';

/// filter dialog when user clicks on the filter button
class FilterDialog extends StatefulWidget {
  FilterDialog({
    this.onModeOptionsChanged,
  });

  final ValueChanged<List<String>> onModeOptionsChanged;

  @override
  FilterDialogState createState() => FilterDialogState();
}

class FilterDialogState extends State<FilterDialog> {
  String newModeOption;
  List<String> modeOptions = [
    "First Letter Start",
    "First Letter Anywhere",
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text("Search filter"),
      children: <Widget>[
        FilterTile("Mode",
            [
              "First Letter Start",
              "First Letter Anywhere",
              "Match Word (Gurmukhi)",
              "Match Word (English)",
              "Ang"]),

        FilterTile("Scripture",
            [
              "Guru Granth Sahib Ji",
              "Dasam Granth Sahib Ji",
              "Bhai Gurdas Ji Vaaran",
              "Bhai Nand Lal Ji"
            ]),
      ],
    );
  }
}