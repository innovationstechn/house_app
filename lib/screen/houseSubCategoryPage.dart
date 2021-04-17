import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app1/model/database_helper_model.dart';
import 'package:provider/provider.dart';
import '../database/database.dart';
import '../appbar/appbar.dart';

class HouseSubCategoryPage extends StatefulWidget {
  final House houseInfo;

  HouseSubCategoryPage({required this.houseInfo});

  @override
  _HouseSubCategoryPage createState() {
    // TODO: implement createState
    return _HouseSubCategoryPage();
  }
}

class _HouseSubCategoryPage extends State<HouseSubCategoryPage> {

  // Creating List of house cards
  List<_DummyCard> items = [
    _DummyCard(no: "1"),
    _DummyCard(no: "2"),
    _DummyCard(no: "3"),
    _DummyCard(no: "4"),
    _DummyCard(no: "5")
  ];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: StandardAppBar(
        title: "House " + widget.houseInfo.houseID.toString(),
      ),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.8,
            child: ListView.builder(
              itemBuilder: (context, position) {
                return Container(
                  child: items[position],
                );
              },
              itemCount: items.length,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.08,
              color: Colors.black12,
              child: Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                      margin: EdgeInsets.all(10),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.blue),
                        child: Text("Ok"),
                        onPressed: () {
                          // Updating House
                          Provider.of<DatabaseHelper>(context,listen:false).updateData(House(houseID: widget.houseInfo.houseID,number:widget.houseInfo.number,visited: true),context);
                          // Check all visited and show dialog on it.
                          Provider.of<DatabaseHelper>(context,listen:false).checkAllVisited().then((value) {
                            if(value){
                              showDialog(context: context,
                                  builder: (_) => AlertDialog(
                                    title: Text('House No 5'),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text("You looked at 11 houses"),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            ElevatedButton(onPressed: (){
                                              //Closing dialog and activity
                                              Navigator.of(context, rootNavigator: true).pop();
                                              Navigator.of(context).pop();}, child: Text("cancel")),
                                            SizedBox(width: 20,),
                                            ElevatedButton(onPressed: (){
                                              //Closing dialog and activity
                                              Provider.of<DatabaseHelper>(context,listen:false).updateAll();
                                              Navigator.of(context, rootNavigator: true).pop();
                                              Navigator.of(context).pop();
                                            }, child: Text("Restart")),
                                          ],)
                                      ],
                                    ),
                                  ));
                            }
                            else
                              Navigator.of(context).pop();
                          });
                        },
                      ))),
            ),
          )
        ],
      ),
    );
  }
}

// Creating card for second activity
class _DummyCard extends StatelessWidget {
  final String no;

  _DummyCard({required this.no});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("No " + this.no,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              ],
            ),
            Card(
              child: Column(
                children: [
                  Container(
                    // color:Colors.black,
                    // height: 60,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            margin: EdgeInsets.only(left: 40),
                            child: Text(
                              "Text",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            )),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Align(
                          alignment: Alignment.bottomLeft,
                          child: Image(
                            image: AssetImage("assets/house.png"),
                            width: MediaQuery.of(context).size.width * 0.3,
                            height: 90,
                          )),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.1,
                        height: 0,
                      ),
                      Container(
                          color: Colors.black12,
                          width: MediaQuery.of(context).size.width * 0.55,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("text"),
                              Text("text"),
                              Text("text")
                            ],
                          )),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
