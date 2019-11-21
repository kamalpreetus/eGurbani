import 'dart:io';
import 'package:flutter2/Model/QueryChoices.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter/services.dart';

import 'QueryResult.dart';


class DatabaseReader
{
  final String DB_NAME = "shabados.sqlite";

  ///
  /// Returns the database. Make sure you close the Database after
  /// using it.
  Future<List<QueryResult>> runQuery(QueryChoices choices, String userInput) async {

    Database db = await getDatabase();
    List<QueryResult> resultList = new List<QueryResult>();
    List<Map> resultFromDB = new List<Map>();

    switch(choices) {
      case QueryChoices.Ang:
        return null;
      case QueryChoices.FirstLetterStart:
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
      case QueryChoices.FirstLetterAnywhere:
        return null;
        break;
      case QueryChoices.ExactWordGurmukhi:
        return null;
        break;
      case QueryChoices.ExactWordEnglish:
        return null;
        break;
      case QueryChoices.Bani:
        return null;
        break;
      case QueryChoices.FirstLetterStart:
        // TODO: Handle this case.
        break;
      case QueryChoices.FirstLetterAnywhere:
        // TODO: Handle this case.
        break;
      case QueryChoices.ExactWordGurmukhi:
        // TODO: Handle this case.
        break;
      case QueryChoices.ExactWordEnglish:
        // TODO: Handle this case.
        break;
      case QueryChoices.Ang:
        // TODO: Handle this case.
        break;
      case QueryChoices.Bani:
        // TODO: Handle this case.
        break;
      case QueryChoices.ShabadID:
        // TODO: Handle this case.
        break;
    }

    return resultList;
  }

  ///
  /// Returns the database. Make sure you close the Database after
  /// using it.
  Future<List<Map>> runQuery2(QueryChoices choices, String userInput) async {

    Database db = await getDatabase();
    List<QueryResult> resultList = new List<QueryResult>();
    List<Map> resultFromDB = new List<Map>();

    switch(choices) {
      case QueryChoices.Ang:
        return null;
      case QueryChoices.FirstLetterStart:
        resultFromDB = await db.rawQuery('SELECT * FROM lines WHERE first_letters LIKE "\%$userInput\%" ORDER BY order_id');
        for (var a in resultFromDB) {
          resultList.add(new QueryResult(
              a["shabad_id"],
              a["source_page"],
              a["first_letters"],
              a["gurmukhi"]));
          print("val " + a["gurmukhi"]);
        }
        return resultFromDB;
      case QueryChoices.FirstLetterAnywhere:
        return null;
        break;
      case QueryChoices.ExactWordGurmukhi:
        return null;
        break;
      case QueryChoices.ExactWordEnglish:
        return null;
        break;
      case QueryChoices.Bani:
        return null;
        break;
      case QueryChoices.FirstLetterStart:
      // TODO: Handle this case.
        break;
      case QueryChoices.FirstLetterAnywhere:
      // TODO: Handle this case.
        break;
      case QueryChoices.ExactWordGurmukhi:
      // TODO: Handle this case.
        break;
      case QueryChoices.ExactWordEnglish:
      // TODO: Handle this case.
        break;
      case QueryChoices.Ang:
      // TODO: Handle this case.
        break;
      case QueryChoices.Bani:
      // TODO: Handle this case.
        break;
      case QueryChoices.ShabadID:
        resultFromDB = await db.rawQuery("SELECT gurmukhi, lines.shabad_id as shabad_id, "
            "lines.source_page, lines.order_id as order_id, translations.line_id, "
            "translations.translation_source_id, translations.translation,  translations.additional_information, "
            "shabads.source_id, writer_id, section_id FROM lines "
            "JOIN shabads ON shabads.id = lines.shabad_id "
            "JOIN translations ON lines.id = translations.line_id "
            "WHERE lines.shabad_id = '$userInput' ORDER BY lines.order_id");
        break;
    }

    return resultFromDB;
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