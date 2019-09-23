import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter/services.dart';

import 'Choices.dart';
import 'QueryResult.dart';


class DatabaseReader
{
  final String DB_NAME = "shabados411.sqlite";

  ///
  /// Returns the database. Make sure you close the Database after
  /// using it.
  Future<List<QueryResult>> runQuery(Choices choices, String userInput) async {

    Database db = await getDatabase();
    List<QueryResult> resultList = new List<QueryResult>();
    List<Map> resultFromDB = new List<Map>();

    switch(choices) {
      case Choices.Ang:
        return null;
      case Choices.FirstLetterStart:
        resultFromDB = await db.rawQuery('SELECT * FROM lines WHERE first_letters LIKE "\%$userInput\%" ORDER BY order_id');
        for (var a in resultFromDB) {
          resultList.add(new QueryResult(
              a["shabad_id"],
              a["source_page"],
              a["first_letters"],
              a["gurmukhi"]));
          print("val " + a["gurmukhi"]);
        }
        return resultList;
      case Choices.FirstLetterAnywhere:
        return null;
        break;
      case Choices.ExactWordGurmukhi:
        return null;
        break;
      case Choices.ExactWordEnglish:
        return null;
        break;
      case Choices.Bani:
        return null;
        break;
    }

    return resultList;
  }

  Future<Database> getDatabase() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, DB_NAME);

    // Check if the database exists
    var exists = await databaseExists(path);

    if (!exists) {
      // Should happen only the first time you launch your application
      print("Creating new copy from asset");

      // Make sure the parent directory exists
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      // Copy from asset
      ByteData data = await rootBundle.load(join("assets", DB_NAME));
      List<int> bytes =
      data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // Write and flush the bytes written
      await File(path).writeAsBytes(bytes, flush: true);

    } else {
      print("Opening existing database");
    }
    // open the database
    Database db = await openDatabase(path, readOnly: true);
    return db;
  }

}