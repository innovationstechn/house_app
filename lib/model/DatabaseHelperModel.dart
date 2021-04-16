import 'package:flutter_app1/database/database.dart';
import 'package:flutter_app1/model/MainHouseModel.dart';


class DatabaseHelper {

  List<MainHouseModel> mainHouseModelList = [];


  void initializeDatabases() async {

    HouseAppDatabase().getOrderedHouses().then((value) => {

      if(value.length>0){
        loadData(value),
      }
      else
      {
          insertData(),
          HouseAppDatabase().getOrderedHouses().then((result) => {
            loadData(result),
          }),
      }
    });
  }

  void loadData(List<House>value) {

    mainHouseModelList.clear();
    int id=1;
    MainHouseModel mainHouseModel= new MainHouseModel();

    for(var house in value){

      if(house.houseID != id){
        mainHouseModel.houseId = id;
        id = house.houseID;
        mainHouseModelList.add(mainHouseModel);
        mainHouseModel = MainHouseModel();
      }

      mainHouseModel.list.add(house.number);
      mainHouseModel.visited.add(house.visited);

    }

  }


  void insertData() {
    for(int i=0;i<5;i++){
      for(int j=0;j<15-i;j++)
        HouseAppDatabase().insertHouse(House(houseID: i+1,number: j+1,visited: false));
    }
  }


}