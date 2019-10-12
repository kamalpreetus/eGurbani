import 'package:flutter2/Model/Shabad/ShabadLine/IShabadLine.dart';

abstract class ICompleteShabad {

  List<IShabadLine> shabadLines;

  int sourcePage;
  int writerID;
  int sectionID;

}