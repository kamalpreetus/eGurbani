import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter2/UI/WidgetUtils/CustomTab.dart';
import 'package:flutter2/UI/SearchWidgets/SearchScreen.dart';
import 'package:flutter2/UI/NitnemWidgets/BaniList.dart';

class Tabbed extends StatefulWidget {
  @override
  _TabbedState createState() => _TabbedState();
}

class _TabbedState extends State<Tabbed> {
  int _currentTab = 0;
  bool isBottomNavVisible = true;

  final List<CustomTab> tabs = <CustomTab>[
    CustomTab(
      child: SearchScreen(),
    ),
    CustomTab(
      child: SearchScreen(),
    ),
    CustomTab(
      child: SearchScreen(),
    ),
    CustomTab(
      child: SearchScreen(),
    ),
  ];

  Future<Null> _setTab(int index) async {
    if (_currentTab == index) {
      if (Navigator.of(tabs[index].tabContext).canPop()) {
        Navigator.of(tabs[index].tabContext)
            .popUntil((Route<dynamic> r) => r.isFirst);
      }
      return;
    }
    setState(() {
      _currentTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: <Widget>[
          _buildStack(),
          _buildTabs(),
        ],
      ),
    );
  }

  Widget _buildStack() {
    return Expanded(
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: IndexedStack(
          sizing: StackFit.expand,
          index: _currentTab,
          children: tabs,
        ),
      ),
    );
  }

  Widget _buildTabs() {
    return SafeArea(
      top: false,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 400),
        height: isBottomNavVisible ? 55.0 : 0.0,
        child: Container(
          decoration: const BoxDecoration(
            //color: Colors.transparent,
            border: Border(
              top: BorderSide(color: Color.fromRGBO(58, 66, 86, 0.3)),
            ),
          ),
          height: 55.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              IconButton(
                iconSize: 30.0,
                color: _currentTab == 0
                    ? Color.fromRGBO(58, 66, 86, 1.0)
                    : Color.fromRGBO(58, 66, 86, 0.3),
                icon: const Icon(Icons.home),
                onPressed: () {
                  _setTab(0);
                },
              ),
              IconButton(
                iconSize: 30.0,
                color: _currentTab == 1
                    ? Color.fromRGBO(58, 66, 86, 1.0)
                    : Color.fromRGBO(58, 66, 86, 0.3),
                icon: const Icon(Icons.search),
                onPressed: () {
                  _setTab(1);
                },
              ),
              IconButton(
                iconSize: 30.0,
                color: _currentTab == 2
                    ? Color.fromRGBO(58, 66, 86, 1.0)
                    : Color.fromRGBO(58, 66, 86, 0.3),
                icon: const Icon(Icons.notifications),
                onPressed: () {
                  _setTab(2);
                },
              ),
              IconButton(
                iconSize: 30.0,
                color: _currentTab == 3
                    ? Color.fromRGBO(58, 66, 86, 1.0)
                    : Color.fromRGBO(58, 66, 86, 0.3),
                icon: const Icon(Icons.settings),
                onPressed: () {
                  _setTab(3);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}