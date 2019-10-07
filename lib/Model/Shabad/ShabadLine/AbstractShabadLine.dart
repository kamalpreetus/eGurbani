import 'package:flutter2/Model/Shabad/ShabadLine/IShabadLine.dart';

abstract class AbstractShabadLine implements IShabadLine {
  int NUM_OF_TRANSLATION_SOURCES;

  @override
  String gurmukhiShabad;

  @override
  int orderID;

  @override
  bool shouldNewLineBeAdded;

  @override
  int sourcePage;

}