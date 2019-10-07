import 'package:flutter2/Model/Shabad/TranslationSource.dart';

abstract class IShabadLine {
  bool shouldNewLineBeAdded;

  // getters
  String gurmukhiShabad;
  int orderID;
  int sourcePage;
  // implement in abstract class
  Map<TranslationSource, String> getTranslations();

  // implement in abstract class
  void setTranslations(TranslationSource translationSource, String translation);
}