// import 'package:flutter/material.dart';
// import 'package:flutter_app1/database/database.dart';
// import 'package:flutter_app1/model/MainHouseModel.dart';
// import 'package:flutter_app1/model/house_model.dart';

// class DatabaseHelper {

//   List<MainHouseModel> mainHouseModelList =[];

//   void initializeDatabases() async {

//     final database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();

//     database.houseProgressDAO.getAllHouseId().then((value) => {

//       if(value.length>0)
//         loadData(value)
//       else {

//         insertData(),
//         database.houseProgressDAO.getAllHouseId().then((value) => {
//         loadData(value)
//         }),
//       }

//     });
//   }

//   void loadData(List<HouseModel>value) async {

//     mainHouseModelList.clear();

//     final database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
//     MainHouseModel mainHouseModel;

//     for(var house in value){
//       database.houseProgressDAO.getHousesById(houseID:house.houseID).then((result) => {

//         mainHouseModel = new MainHouseModel(),
//         mainHouseModel.houseId = house.houseID,

//         for(var temp in result){
//           mainHouseModel.list.add(temp.number),
//           mainHouseModel.visited.add(temp.visited),
//         },
//         mainHouseModelList.add(mainHouseModel),
//       });
//     }
//   }

//   static insertData() async {
//     final database = HouseAppDatabase();

//         for(int i=0;i<5;i++){
//           for(int j=0;j<15;j++) {

//             House house = new House(
//                 houseID: i + 1, number: j + 1, visited: false);
//             database.insertHouse(house);

//           }
//         }
//       }

//       void updateData(HouseModel houseModel) async {
//         final database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
//         database.houseProgressDAO.updateProgress(houseModel);
//       }

//       void restartData() async{
//         final database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();

//         for(int i=0;i<5;i++){
//           for(int j=0;j<15;j++) {
//             HouseModel houseModel = new HouseModel(
//                 houseID: i + 1, number: j + 1, visited: false);
//             database.houseProgressDAO.updateProgress(houseModel);
//           }
//         }

//         database.houseProgressDAO.getAllHouseId().then((value) => {
//           loadData(value)
//         });
//       }

//     }

//     class $HouseAppDatabase}
