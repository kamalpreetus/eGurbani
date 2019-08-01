import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomNavigationBarWidget extends StatelessWidget {
  const BottomNavigationBarWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.search, color: Colors.black),
            title: Text('Search'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book, color: Colors.black),
            title: Text('Nitnem'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school, color: Colors.black),
            title: Text('Sehaj Path'),
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.settings,
                color: Colors.black,
              ),
              title: Text("Settings"))
        ],
        selectedItemColor: Colors.amber[800],
        onTap: (int i) => print("onTap bottomNavBar item " + i.toString()));
  }
}