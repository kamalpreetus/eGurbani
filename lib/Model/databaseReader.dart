import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter/services.dart';

import 'QueryChoices.dart';
import 'QueryResult.dart';


class DatabaseReader
{
  final String DB_NAME = "shabados.sqlite";

  ///
  /// Returns the query. Make sure you close the Database after
  /// using it.
  Future<List<QueryResult>> runQuery(QueryChoices choices, String userInput) async {

    Database db = await getDatabase();
    List<QueryResult> resultList = new List<QueryResult>();
    List<Map> resultFromDB = new List<Map>();

    switch(choices) {
      case QueryChoices.ShabadID:
        resultFromDB = await db.rawQuery(''
            'SELECT * FROM lines '
            'WHERE shabad_id = "$userInput" '
            'ORDER BY order_id');
        break;
      case QueryChoices.Ang:
        return null;
      case QueryChoices.FirstLetterStart:
        resultFromDB = await db.rawQuery(''
            'SELECT * FROM lines '
            'WHERE lines.first_letters GLOB "$userInput*" '
            'ORDER BY lines.order_id ');
        addToresultList(resultFromDB, resultList);
        return resultList;
      case QueryChoices.FirstLetterAnywhere:
        return null;
        break;
      case QueryChoices.ExactWordGurmukhi:
        await getRehrasSahib(resultFromDB, db, resultList);

        for (var m in resultList) {

        }

        break;
      case QueryChoices.ExactWordEnglish:
        return null;
        break;
      case QueryChoices.Bani:
      //resultFromDB = await getRehrasSahib(resultFromDB, db, resultList);

        resultFromDB = await db.rawQuery("SELECT * FROM lines "
            "JOIN bani_lines ON bani_lines.line_id = lines.id "
            "WHERE bani_lines.bani_id = $userInput "
            "ORDER BY bani_lines.line_group, lines.order_id");
        addToresultList(resultFromDB, resultList);
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
      case QueryChoices.ShabadID:
        resultFromDB = await db.rawQuery("SELECT gurmukhi, lines.shabad_id as shabad_id, "
            "lines.source_page, lines.order_id as order_id, translations.line_id, "
            "translations.translation_source_id, translations.translation,  translations.additional_information, "
            "shabads.source_id, writer_id, section_id FROM lines "
            "JOIN shabads ON shabads.id = lines.shabad_id "
            "JOIN translations ON lines.id = translations.line_id "
            "WHERE lines.shabad_id = '$userInput' ORDER BY lines.order_id");
        break;
      case QueryChoices.Ang:
        return null;
      case QueryChoices.FirstLetterStart:
        resultFromDB = await db.rawQuery(''
            'SELECT * FROM lines '
            'WHERE lines.first_letters GLOB "$userInput*" '
            'ORDER BY lines.order_id ');
        addToresultList(resultFromDB, resultList);
        return resultFromDB;
      case QueryChoices.FirstLetterAnywhere: // contains
        resultFromDB = await db.rawQuery(''
            'SELECT * FROM lines '
            'WHERE lines.first_letters GLOB "*$userInput*" '
            'ORDER BY lines.order_id ');
        addToresultList(resultFromDB, resultList);
        break;
      case QueryChoices.ExactWordGurmukhi:
        break;
      case QueryChoices.ExactWordEnglish:
        break;
      case QueryChoices.Bani:
        resultFromDB = await db.rawQuery("SELECT * FROM lines "
            "JOIN bani_lines ON bani_lines.line_id = lines.id "
            "WHERE bani_lines.bani_id = $userInput "
            "ORDER BY bani_lines.line_group, lines.order_id");
        addToresultList(resultFromDB, resultList);
        break;
    }

    return resultFromDB;
  }

  Future<List<Map>> getRehrasSahib(List<Map> resultFromDB, Database db, List<QueryResult> resultList) async {
    List<String> untilChaupai = ["A5W", "KQK", "4CW", "9UG", "SPX", "DYZ", "38V", "823", "8GT", "JHX", "919"];
    String chaupaiQuery = "SELECT * FROM lines "
        "JOIN bani_lines ON bani_lines.line_id = lines.id "
        "WHERE bani_lines.bani_id = 4 "
        "ORDER BY order_id, lines.order_id";
    String kripaKari = "SELECT * FROM lines where lines.order_id >= 126506 AND lines.order_id <= 126523";
    List<String> swayivaDohra = ["VNG", "78Q"];
    List<String> anadSahibAndSmapti = ["A3M", "BWP", "0Q9", "EUW", "A9Y"];


    for (String s in untilChaupai) {
      resultFromDB = await db.rawQuery("SELECT * FROM lines where shabad_id = 'A5W'");
      addToresultList(resultFromDB, resultList);
    }

    resultFromDB = await db.rawQuery(chaupaiQuery);
    addToresultList(resultFromDB, resultList);

    resultFromDB = await db.rawQuery(kripaKari);
    addToresultList(resultFromDB, resultList);

    for (String s in anadSahibAndSmapti) {
      resultFromDB = await db.rawQuery("SELECT * FROM lines where shabad_id = 'A5W'");
      addToresultList(resultFromDB, resultList);
    }

    return resultFromDB;
  }

  void addToresultList(List<Map> resultFromDB, List<QueryResult> resultList) {
    for (var a in resultFromDB) {
      resultList.add(new QueryResult(
          a["shabad_id"],
          a["source_page"],
          a["first_letters"],
          a["gurmukhi"]));
      print("val " + a["gurmukhi"]);
    }
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