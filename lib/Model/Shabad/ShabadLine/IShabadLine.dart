import 'package:flutter2/Model/Shabad/TranslationSource.dart';

abstract class IShabadLine {

  String gurmukhiShabad;
  int orderID;
  int sourcePage;
  int writerID;
  int sectionID;

  // implement in abstract class
  void setTranslations(TranslationSource translationSource, String translation);
}