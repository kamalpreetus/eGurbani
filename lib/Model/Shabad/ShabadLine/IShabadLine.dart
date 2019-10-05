import 'package:flutter2/Model/Shabad/TranslationSource.dart';

abstract class IShabadLine {
  bool shouldNewLineBeAdded();

  // getters
  String getGurmukhiShabad();
  int getOrderID();
  int getSourcePage();
  // implement in abstract class
  Map<TranslationSource, String> getTranslations();

  // setters
  void setGurmukhiShabad(String gurmukhiShabad);
  void setOrderID(int orderID);
  void setSourcePage(int sourcePage);
  // implement in abstract class
  void setTranslations(TranslationSource translationSource, String translation);
}