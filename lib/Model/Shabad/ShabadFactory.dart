import 'package:flutter2/Model/Shabad/ShabadLine/ShabadLine.dart';
import 'package:flutter2/Model/Shabad/ShabadLine/IShabadLine.dart';
import 'package:flutter2/Model/Shabad/ShabadSource.dart';
import 'package:flutter2/Model/Shabad/TranslationSource.dart';

/// Responsible for generating IShabadLines.
class ShabadFactory {
  IShabadLine getShabadByID(int shabadID) {

  }

  /// Converts raw SQL output from DB to list of shabad lines.
  static List<IShabadLine> generateShabadLinesDB(List<Map> rawShabadResult) {
    List<IShabadLine> shabadLines = new List();

    /* set the type of shabad by looking at the 'lines.source_id' column.
    We only look at the first row since all rows should have the same source id for a given shabad. */
    ShabadSource sourceType = ShabadFactory.getShabadSourceType(rawShabadResult.first["source_id"]);

    int prevOrderID = rawShabadResult.first["order_id"];
    int curOrderID;
    IShabadLine shabadLine = ShabadFactory.generateShabadLineFromMap(rawShabadResult.first, sourceType);

    for (Map curShabadRow in rawShabadResult) {

      curOrderID = curShabadRow["order_id"];

      if (ShabadFactory.haveAllTranslationBeenAddedToTheShabadLine(prevOrderID, curOrderID)) {
        shabadLines.add(shabadLine);
        shabadLine = ShabadFactory.generateShabadLineFromMap(curShabadRow, sourceType);
      }
      
      TranslationSource translationSource = ShabadFactory.getTranslationSrcToAdd(curShabadRow["translation_source_id"]);
      addTranslationToShabadLine(shabadLine, translationSource, curShabadRow["translation"]);

      prevOrderID = curOrderID;
    }

    // add the last shabad line since the last instance will be skipped above.
    shabadLines.add(shabadLine);
    return shabadLines;
  }

  /// Determines if all the translation have been added for a shabad line.
  /// Let's use Guru Granth Sahib Ji shabad line as an example, since the
  /// same shabad will repeat 6 times because there are 6 translation sources,
  /// meaning that there are 6 rows or the same shabad. When a shabad moves
  /// to the next shabad, the 'order_id' column will increase by 1 as well,
  /// so that why [prevOrderID] and [curOrderID] are compared here. Then, we
  /// can say that a shabad line has been successfully been created.
  static bool haveAllTranslationBeenAddedToTheShabadLine(int prevOrderID, int curOrderID) {
    return prevOrderID != curOrderID;
  }

  /// Gets the source type of the shabad based on the [sourceID]. The mappings
  /// are based on the
  //  /// shabad os database.
  static ShabadSource getShabadSourceType(int sourceID) {
    switch (sourceID) {
      case 1:
        return ShabadSource.GURU_GRANTH_SAHIB_JI;
      case 2:
        return ShabadSource.DASAM_GRANTH_SAHIB_JI;
      case 3:
        return ShabadSource.VAARAN_BHAI_GURDAS_JI;
      case 4:
        return ShabadSource.KABIT_BHAI_GURDAS_JI;
      default:
        return ShabadSource.INVALID_SOURCE;
    }
  }

  /// Gets the translation source to be added based on the [translationSourceID]. 
  /// The mappings are based on the shabad os database.
  static TranslationSource getTranslationSrcToAdd(int translationSourceID) {
    switch (translationSourceID) {
      case 1:
        return TranslationSource.SANT_SINGH_ENGLISH;
      case 2:
        return TranslationSource.MANMOHAN_SINGH_ENGLISH;
      case 3:
        return TranslationSource.MANMOHAN_SINGH_PUNJABI;
      case 4:
        return TranslationSource.SIKHNET_SPANISH;
      case 5:
        return TranslationSource.FAREEDKOT_PUNJABI;
      case 6:
        return TranslationSource.PROF_SAHIB_SINGH_PUNJABI;
      case 7:
        return TranslationSource.SURINDER_SINGH_KOHLI;
      case 8:
        return TranslationSource.RATTAN_SINGH_JAGGI;
      case 9:
        return TranslationSource.SGPC;
      case 10:
        return TranslationSource.DR_JODH_SINGH;
      case 11:
        return TranslationSource.BHAI_VIR_SINGH;
      case 12:
      case 14:
      case 16:
      case 18:
        return TranslationSource.PRITPAL_SINGH_BINDRA_ENGLISH;
      case 13:
      case 15:
      case 17:
      case 19:
        return TranslationSource.DR_GANDA_SINGH_PUNJABI;
    }
    
    return TranslationSource.INVALID;
  }

  /// Generates a shabad line for the [shabadRow] row for a given [sourceType].
  static IShabadLine generateShabadLineFromMap(Map shabadRow, ShabadSource sourceType) {
    String gurmukhiShabad = shabadRow["gurmukhi"];
    int orderId = shabadRow["order_id"];
    int writerID = shabadRow["writer_id"];
    int sourcePage = shabadRow["source_page"];
    int sectionID = shabadRow["section_id"]; // raag id

    IShabadLine shabadLine = new ShabadLine();
    shabadLine.gurmukhiShabad = gurmukhiShabad;
    shabadLine.orderID = orderId;
    shabadLine.writerID = writerID;
    shabadLine.sourcePage = sourcePage;
    shabadLine.sectionID = sectionID;

    return shabadLine;
  }

  /// Sets the [translation] on the [shabadLine] for a given [translationSrcToAdd].
  static void addTranslationToShabadLine(IShabadLine shabadLine, TranslationSource translationSrcToAdd, String translation) {
    shabadLine.setTranslations(translationSrcToAdd, translation);
  }
}