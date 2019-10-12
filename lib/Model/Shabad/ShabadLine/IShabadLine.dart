import 'package:flutter2/Model/Shabad/TranslationSource.dart';

abstract class IShabadLine {

  String gurmukhiShabad;
  int orderID;

  // implement in abstract class
  void setTranslations(TranslationSource translationSource, String translation);
}