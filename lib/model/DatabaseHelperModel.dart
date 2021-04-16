import 'package:flutter/cupertino.dart';
import 'package:flutter_app1/database/database.dart';
import 'package:flutter_app1/model/MainHouseModel.dart';

class DatabaseHelper extends ChangeNotifier {

  List<MainHouseModel> _mainHouseModelList = [];

  List<MainHouseModel> get mainHouseModelList => _mainHouseModelList;

  HouseAppDatabase database = new HouseAppDatabase();

   void initializeDatabases() {

    database.getOrderedHouses().then((value) => {
      if(value.length>0){
        loadData(value),
      }
      else
      {
          insertData(),
          database.getOrderedHouses().then((result) => {
            loadData(result),
          }),
      }
    }).then((value) => {

    });
  }

  void loadData(List<House>value) {

    _mainHouseModelList.clear();
    int id=1;
    MainHouseModel mainHouseModel= new MainHouseModel();

    for(var house in value){

      if(house.houseID != id){
        mainHouseModel.houseId = id;
        id = house.houseID;
        _mainHouseModelList.add(mainHouseModel);
        mainHouseModel = MainHouseModel();
      }

      mainHouseModel.list.add(house.number);
      mainHouseModel.visited.add(house.visited);

    }

    notifyListeners();

  }


  void insertData() {
    for(int i=0;i<5;i++){
      for(int j=0;j<15-i;j++)
        database.insertHouse(House(houseID: i+1,number: j+1,visited: false));
    }
  }

  void updateData(House house){
    database.updateHouse(house).then((value) => {
      initializeDatabases(),
    });
  }

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