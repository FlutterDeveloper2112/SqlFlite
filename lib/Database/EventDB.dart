
import 'dart:convert';

import 'package:snapwork_interview/Model/Event.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


class EventDB{
  Database db;

  static Future<Database> database() async {
    return openDatabase(join(await getDatabasesPath(), "eventDetails.db"),

      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE EVENTDETAILS(year INTEGER,month STRING,date INTEGER PRIMARY KEY ,eventTitle STRING,eventDesc STRING)",
        );

      },
      version: 1,
    );

  }
  void createOrUpdateObject(Event event) async {
    var db = await openDatabase('eventDetails.db');
    await db.insert("EVENTDETAILS", event.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

 Future<dynamic> getEventDetails(int year,String month,int date) async {

   var db = await openDatabase('eventDetails.db');
    var result = await db.rawQuery(''' SELECT * FROM EVENTDETAILS WHERE year = '$year' AND month = '$month'  AND  date='$date' ''');
   return Event.fromJson(result);

  }


  Future<List<Event>> eventList() async {
    var db = await openDatabase('eventDetails.db');
    final List<Map<String, dynamic>> maps = await db.query('EVENTDETAILS');
    print("DATABASE LENGTH: ${maps[0]}");

    return List.generate(maps.length, (i) {
      return Event(
        year: maps[i]['year'],
        date: maps[i]['date'],
        month: maps[i]['month'],
        event:maps[i]["eventTitle"],
        eventDescrp:maps[i]["eventDesc"],

      );
    });
  }
 }