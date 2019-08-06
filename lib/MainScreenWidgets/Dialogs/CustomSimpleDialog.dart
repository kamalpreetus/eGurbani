
import 'package:flutter/material.dart';

import 'package:flutter2/MainScreenWidgets/Dialogs/FilterTile.dart';

/// filter dialog when user clicks on the filter button
class CustomSimpleDialog extends StatefulWidget {
  CustomSimpleDialog({
    this.cities,
    this.selectedCities,
    this.onSelectedCitiesListChanged,
  });

  final List<String> cities;
  final List<String> selectedCities;
  final ValueChanged<List<String>> onSelectedCitiesListChanged;

  @override
  CustomSimpleDialogState createState() => CustomSimpleDialogState();
}

class CustomSimpleDialogState extends State<CustomSimpleDialog> {
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
        FilterTile("Mode", [
          "First Letter Start",
          "First Letter Anywhere",
          "Match Word (Gurmukhi)",
          "Match Word (English)",
          "Ang"
        ]),
        FilterTile("Scripture", [
          "Guru Granth Sahib Ji",
          "Dasam Granth Sahib Ji",
          "Bhai Gurdas Ji Vaaran",
          "Bhai Nand Lal Ji"
        ]),
      ],
    );
  }
}