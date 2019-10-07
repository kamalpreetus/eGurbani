import 'package:flutter2/Model/Shabad/ShabadLine/DasamGranthSahibLine.dart';
import 'package:flutter2/Model/Shabad/ShabadLine/GuruGranthSahibLine.dart';
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
    IShabadLine shabadLine = ShabadFactory.generateShabadLineFromMap(rawShabadResult.first["order_id"], sourceType);

    for (Map curShabadLine in rawShabadResult) {

      curOrderID = curShabadLine["order_id"];

      if (haveAllTranslationBeenAddedToTheShabadLine(prevOrderID, curOrderID)) {
        shabadLines.add(shabadLine);
        shabadLine = ShabadFactory.generateShabadLineFromMap(curShabadLine, sourceType);
      }
      
      TranslationSource translationSource = ShabadFactory.getTranslationSrcToAdd(curShabadLine["translation_source_id"]);
      addTranslationsToShabadLine(shabadLine, translationSource, curShabadLine["translation"]);

      prevOrderID = curOrderID;
    }
  }

  /// Determines if all the translation have been added for a shabad line.
  /// This is a bit hacky but it works: let's use Guru Granth Sahib Ji
  /// shabad line as an example, since the same shabad will repeat 6 times
  /// because there are 6 translation sources, meaning that there are 6 rows
  /// for the same shabad. When a shabad moves to the next shabad, the 'order_id'
  /// column will increase by 1 as well, so that why [prevOrderID] and
  /// [curOrderID] are compared here. Then, we can say that a shabad line
  /// has been successfully been created.
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
        return TranslationSource.MANMOHAN_SINGH_PUNJABI;
      case 3:
        return TranslationSource.MANMOHAN_SINGH_ENGLISH;
      case 4:
        return TranslationSource.SIKHNET_SPANISH;
      case 5:
        return TranslationSource.FAREEDKOT_PUNJABI;
      case 6:
        return TranslationSource.PROF_SAHIB_SINGH_PUNJABI;
      case 7:
        return TranslationSource.INVALID;
    }
    return TranslationSource.INVALID;
  }

  static IShabadLine generateShabadLineFromMap(Map curShabadLine, ShabadSource sourceType) {

    // additional properties: raag, source_page, gurmukhi, order_id, section_id (raag), etc.
    bool setAdditionalPropertisOnShabadLine = true;

    String gurmukhiShabad = curShabadLine["gurmukhi"];
    int orderId = curShabadLine["order_id"];

    IShabadLine shabadLine;

    switch (sourceType) {
      case ShabadSource.GURU_GRANTH_SAHIB_JI:
        shabadLine = new GuruGranthSahibLine();
        shabadLine.gurmukhiShabad = gurmukhiShabad;
        shabadLine.orderID = orderId;
        return shabadLine;
        break;
      case ShabadSource.DASAM_GRANTH_SAHIB_JI:
        shabadLine = new DasamGranthSahibLine();
        shabadLine.gurmukhiShabad = gurmukhiShabad;
        shabadLine.orderID = orderId;
        break;

      case ShabadSource.VAARAN_BHAI_GURDAS_JI:
        // TODO: Handle this case.
        break;
      case ShabadSource.KABIT_BHAI_GURDAS_JI:
        // TODO: Handle this case.
        break;
      case ShabadSource.BHAI_NAND_LAL_JI:
        // TODO: Handle this case.
        break;
      case ShabadSource.INVALID_SOURCE:
        // TODO: Handle this case.
        break;
    }

    return shabadLine;
  }

  /// Sets the [translation] on the [shabadLine] for a given [translationSrcToAdd].
  static void addTranslationsToShabadLine(IShabadLine shabadLine, TranslationSource translationSrcToAdd, String translation) {
    shabadLine.setTranslations(translationSrcToAdd, translation);
  }
}