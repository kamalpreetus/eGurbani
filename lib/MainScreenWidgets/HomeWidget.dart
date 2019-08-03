import 'package:flutter/material.dart';

import 'NitnemWidget.dart';
import 'SearchWidget.dart';

class HomePageWidget extends StatefulWidget {
  HomePageWidget({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  int _currentIndex = 0;

  final List<Widget> _children = [
    FloatingSearchWidget(),
    NitnemWidget(Colors.deepOrange),
    NitnemWidget(Colors.green),
    NitnemWidget(Colors.blue)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // using IndexedStack allow us to persist UI state, it keeps pages alive
      body: IndexedStack(
        index: _currentIndex,
        children: _children,
      ),
      bottomNavigationBar: BottomNavigationBar(
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
          onTap: (int i) => onTabTapped(i),
          currentIndex: _currentIndex
      ),
    );
  }

  void onTabTapped(int index) {
    print("onTap bottomNavBar item " + index.toString());

    setState(() {
      _currentIndex = index;
    });

  }
}


