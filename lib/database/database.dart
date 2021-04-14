// database.dart

// required package imports
import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import '../model/house_model.dart';
import 'house_dao.dart';

part 'database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [HouseModel])
abstract class AppDatabase extends FloorDatabase {
  HouseDAO get houseProgressDAO;
}
