import 'package:floor/floor.dart';

@entity
class HouseModel {
  @primaryKey
  final int houseID;

  @primaryKey
  final int number;

  final bool visited;

  HouseModel(
      {required this.houseID, required this.number, required this.visited});
}
