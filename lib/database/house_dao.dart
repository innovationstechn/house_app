// import 'package:floor/floor.dart';
// import '../model/house_model.dart';
//
// @dao
// abstract class HouseDAO {
//   @Query('SELECT * FROM HouseModel ORDER BY houseID')
//   Future<List<HouseModel>> getAllProgress();
//
//   @Query('SELECT DISTINCT houseID FROM HouseModel')
//   Future<List<HouseModel>> getAllHouseId();
//
//   @Query('SELECT * FROM HouseModel WHERE houseID = :houseID')
//   Future<List<HouseModel>> getHousesById({required int houseID});
//
//   @update
//   Future<void> updateProgress(HouseModel progress);
//
//   @insert
//   Future<void> newProgress(HouseModel person);
//
//   @delete
//   Future<void> deleteProgress(HouseModel progress);
//
//   @Query('SELECT * FROM HouseModel WHERE houseID = :houseID AND number = :number')
//   Future<HouseModel?> getHouse({required int houseID, required int number});
// }
