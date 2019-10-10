import 'package:flutter2/Model/QueryChoices.dart';
import 'package:flutter2/Model/Shabad/ShabadFactory.dart';
import 'package:flutter2/Model/Shabad/ShabadLine/IShabadLine.dart';
import 'package:flutter2/Model/databaseReader.dart';

class ShabadFinder {
  Future<List<IShabadLine>> generateShabadLine(String shabadID) async {
    DatabaseReader db = new DatabaseReader();
    List<Map> rawShabadResult = await db.runQuery2(QueryChoices.ShabadID, "9N9");
    
    // take the raw result returned from DB and convert it to list of IShabadLines
    List<IShabadLine> shabadLines = ShabadFactory.generateShabadLinesDB(rawShabadResult);
    print("printing\t" + rawShabadResult.toString());
    return shabadLines;
  }
  
}