import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_app1/database/database.dart';
import 'package:flutter_app1/model/MainHouseModel.dart';

class DatabaseHelper extends ChangeNotifier {
  List<MainHouseModel> _mainHouseModelList = [];

  List<MainHouseModel> get mainHouseModelList => _mainHouseModelList;
  HouseAppDatabase database = new HouseAppDatabase();
  late Stream<List<House>> watcher;

  DatabaseHelper() {
    watcher = database.allHousesStream();

    // This listener updates _mainHouseModelList with the latest version of
    // data from the database when any change occurs + at the start of the
    // program.
    watcher.listen((event) async {
      _mainHouseModelList.clear();

      List<int?> houseIds = await database.getDistinctHouses();

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

          MainHouseModel model = new MainHouseModel();
          model.houseId = houseId;
          model.visited = visitieds;
          model.list = numbers;

          _mainHouseModelList.add(model);
        }
      }

      notifyListeners();
    });

    // Fill up houses with dummy data if no data is present.
    database.getAllHouses().then((houses) {
      if (houses.isEmpty) insertData();
    });
  }

  void initializeDatabases() {
    database.getOrderedHouses().then((value) async {
      if (value.length > 0)
        loadData(value);
      else {
        await insertData();
        database.getOrderedHouses().then((result) {
          loadData(result);
        });
      }

      notifyListeners();
    });
  }

  void loadData(List<House> value) {
    _mainHouseModelList.clear();
    int id = 1;
    MainHouseModel mainHouseModel = new MainHouseModel();

    for (var house in value) {
      if (house.houseID != id) {
        mainHouseModel.houseId = id;
        id = house.houseID;
        _mainHouseModelList.add(mainHouseModel);
        mainHouseModel = MainHouseModel();
      }

      mainHouseModel.list.add(house.number);
      mainHouseModel.visited.add(house.visited);
    }
  }

  Future<void> insertData() async {
    for (int i = 0; i < 5; i++) {
      for (int j = 0; j < 15 - i; j++)
        await database
            .insertHouse(House(houseID: i + 1, number: j + 1, visited: false));
    }
  }

  Future updateData(House house) => database.updateHouse(house);
}

// import 'package:flutter_app1/database/database.dart';
// import 'package:flutter_app1/model/MainHouseModel.dart';
//
//
// class DatabaseHelper {
//
//   static List<MainHouseModel> mainHouseModelList = [];
//   static HouseAppDatabase database = new HouseAppDatabase();
//
//   static void initializeDatabases() async {
//
//     database.getOrderedHouses().then((value) => {
//
//       if(value.length>0){
//         loadData(value),
//       }
//       else
//         {
//           insertData(),
//           database.getOrderedHouses().then((result) => {
//             loadData(result),
//           }),
//         }
//     });
//   }
//
//   static void loadData(List<House>value) {
//
//     mainHouseModelList.clear();
//     int id=1;
//     MainHouseModel mainHouseModel= new MainHouseModel();
//
//     for(var house in value){
//
//       if(house.houseID != id){
//         mainHouseModel.houseId = id;
//         id = house.houseID;
//         mainHouseModelList.add(mainHouseModel);
//         mainHouseModel = MainHouseModel();
//       }
//
//       mainHouseModel.list.add(house.number);
//       mainHouseModel.visited.add(house.visited);
//
//     }
//
//   }
//
//
//   static void insertData() {
//     for(int i=0;i<5;i++){
//       for(int j=0;j<15-i;j++)
//         database.insertHouse(House(houseID: i+1,number: j+1,visited: false));
//     }
//   }
//
//   static void updateData(House house){
//     database.updateHouse(house);
//     initializeDatabases();
//   }
//
// }
