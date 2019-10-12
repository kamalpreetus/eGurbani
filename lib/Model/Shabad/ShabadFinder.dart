import 'package:flutter2/Model/QueryChoices.dart';
import 'package:flutter2/Model/Shabad/ICompleteShabad.dart';
import 'package:flutter2/Model/Shabad/ShabadFactory.dart';
import 'package:flutter2/Model/databaseReader.dart';

class ShabadFinder {
  Future<ICompleteShabad> generateShabadLine(String shabadID) async {
    DatabaseReader db = new DatabaseReader();
    List<Map> rawShabadResult = await db.runQuery2(QueryChoices.ShabadID, shabadID);
    
    // take the raw result returned from DB and convert it to list of IShabadLines
    ICompleteShabad completeShabad = ShabadFactory.convertFromSqlToCompleteShabad(rawShabadResult);
    print("printing\t" + rawShabadResult.toString());
    return completeShabad;
  }
  
}