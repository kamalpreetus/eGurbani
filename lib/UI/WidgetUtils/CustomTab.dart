import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

/// Creates an ios style tab
class CustomTab extends StatelessWidget {
  final Widget child;
  BuildContext tabContext;

  CustomTab({@required this.child});

  @override
  Widget build(BuildContext context) {
    return CupertinoTabView(
      builder: (BuildContext context) {
        tabContext = context;
        return child;
      },
    );
  }
}