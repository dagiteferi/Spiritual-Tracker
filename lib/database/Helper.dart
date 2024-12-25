import 'package:sqflite/sqflite.dart';

class PersonDatabaseHelper {
  static PersonDatabaseHelper?
      _personDatabaseHelper; //Singleton object of the class
  static Database? _database;
}
