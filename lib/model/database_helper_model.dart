import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:house_app/database/database.dart';
import 'package:house_app/model/MainHouseModel.dart';

class DatabaseHelper extends ChangeNotifier {
  List<MainHouseModel> _mainHouseModelList = [];

  List<MainHouseModel> get mainHouseModelList => _mainHouseModelList;
  HouseAppDatabase database = new HouseAppDatabase();
  bool dialogOpen = false;
  House houseInfo = House(houseID: 0, number: 0, visited: false);

  DatabaseHelper() {
    loadData();
    // Fill up houses with dummy data if no data is present.
    database.getAllHouses().then((houses) {
      if (houses.isEmpty) {
        insertData();
        loadData();
      };
    });
  }

  // Load data from database
  void loadData() async {
    _mainHouseModelList.clear();
    // Getting houseId's for fetching their sub houses
    List<int?> houseIds = await database.getDistinctHouses();

    // Fetching sub houses of the corresponding house id.
    for (int i = 0; i < houseIds.length; i++) {
      if (houseIds[i] != null) {
        int houseId = houseIds[i] as int;

        List<House> subHouses = await database.getHouseById(houseId);
        List<int> numbers = [];
        List<bool> visitieds = [];

        subHouses.forEach((House subHouse) {
          numbers.add(subHouse.number);
          visitieds.add(subHouse.visited);
        });

        // Creating model for Main House Model list used for building UI.
        MainHouseModel model = new MainHouseModel();
        model.houseId = houseId;
        model.visited = visitieds;
        model.list = numbers;
        //Adding houses with their sub houses
        _mainHouseModelList.add(model);
      }
    }

    notifyListeners();
  }

  // Insert data into database
  Future<void> insertData() async {
    // Here we can set no of houses and sub houses
    int setHouseIds = 3;
    int setSubHouses = 3;

    for (int i = 0; i < setHouseIds; i++) {
      for (int j = 0; j < setSubHouses - i; j++) {
        await database
            .insertHouse(House(houseID: i + 1, number: j + 1, visited: false))
            .then((value) {
          // Loading list when all the data is inserted into database
          if (i == setHouseIds - 1 && j == setSubHouses - i - 1)
            loadData();
        });
      }
    }
  }

  // Restarting all the houses
  Future<void> updateAll() async {
    _mainHouseModelList.clear();
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3 - i; j++)
        await database
            .updateHouse(House(houseID: i + 1, number: j + 1, visited: false));
    }
    loadData();
  }

  // Update house
  Future updateData(House house) async {
    database.updateHouse(house);
    loadData();
  }

  // This method used for checking all the houses visited or not.
  Future<bool> checkAllVisited() async {
    return (await database.checkAllVisited(false)).isEmpty;
  }

  // This method used for checking all sub houses are visited or not.
  Future<bool> allHousesVisited(int houseId) async {
    return (await database.areAllHousesVisited(houseId));
  }

  // It will give the last sub house number of particular house.
  Future<House?> getLastHouse(int houseId) async {
    return (await database.getLastHouse(houseId));
  }

  // It will give last sub house
  Future<House?> getLast() async{
    int house=0;
    return await database.getDistinctHouses().then((value) async {
      if(value.last!=null)
         house = value.last!;
      return (await database.getLastHouse(house));
    });
  }
}
