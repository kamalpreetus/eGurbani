import 'package:flutter2/Model/Shabad/ICompleteShabad.dart';
import 'package:flutter2/Model/Shabad/ShabadLine/IShabadLine.dart';

class CompleteShabad implements ICompleteShabad {

  CompleteShabad(this.shabadLines);

  /// This is the raag ID
  @override
  int sectionID;

  @override
  List<IShabadLine> shabadLines;

  @override
  int sourcePage;

  @override
  int writerID;

}