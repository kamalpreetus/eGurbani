import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

import 'QueryResult.dart';


class DatabaseReader
{
  final String DB_NAME = "shabados.sqlite";

  ///
  /// Returns the database. Make sure you close the Database after
  /// using it.
  Future<List<QueryResult>> runQuery() async {
    // Get a location using getDatabasesPath
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
    List<Map> list = await db.rawQuery('SELECT * FROM lines WHERE first_letters LIKE "\%hhhh\%" ORDER BY order_id');

    List<QueryResult> resultList = new List<QueryResult>();
    for (var a in list) {
      resultList.add(new QueryResult(a["shabad_id"], a["source_page"],
                                    a["first_letters"], a["gurmukhi"]));
      print("val " + a["first_letters"]);
    }

    //await db.close();

    return resultList;
  }

}