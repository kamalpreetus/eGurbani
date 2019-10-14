import 'package:flutter2/Model/Shabad/ShabadLine/IShabadLine.dart';
import 'package:flutter2/Model/Shabad/TranslationSource.dart';

class ShabadLine implements IShabadLine {

  @override
  Map<TranslationSource, String> translationsMap;

  @override
  String gurmukhiShabad;

  @override
  int orderID;

  @override
  int sourcePage;

  @override
  int sectionID;

  @override
  int writerID;

  ShabadLine() {
    translationsMap = new Map();
  }

  @override
  void setTranslations(TranslationSource translationSource, String translation) {
    translationsMap[translationSource] = translation;
  }
}