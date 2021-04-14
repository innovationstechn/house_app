import 'package:floor/floor.dart';
import '../model/house_model.dart';

@dao
abstract class HouseDAO {
  @Query('SELECT * FROM Person')
  Future<List<HouseModel>> getAllProgress();

  @update
  Future<void> updateProgress(HouseModel progress);

  @insert
  Future<void> newProgress(HouseModel person);

  @delete
  Future<void> deleteProgress(HouseModel progress);

  @Query('SELECT * FROM Person WHERE houseID = :houseID AND number = :number')
  Future<HouseModel?> getHouse({required int houseID, required int number});
}
