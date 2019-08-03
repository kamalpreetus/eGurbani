import 'package:flutter/material.dart';

class NitnemWidget extends StatelessWidget {
  final Color color;

  NitnemWidget(this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
    );
  }
}