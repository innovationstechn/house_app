import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screen/House.dart';
import 'model/database_helper_model.dart';
import 'appbar/appbar.dart';

void main() {
  runApp(ChangeNotifierProvider<DatabaseHelper>(
      create: (context) => DatabaseHelper(),
      builder: (context, child) {
        return MyApp();
      }));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({required this.title});

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: StandardAppBar(
        title: "",
      ),
      body: Consumer<DatabaseHelper>(
        builder: (context, snapshot, child) {

          // Check all visited and show dialog on it.
          Provider.of<DatabaseHelper>(context,listen:false).checkAllVisited().then((value) {
            if(value==true){
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
                              Navigator.of(context).pop();}, child: Text("cancel")),
                            SizedBox(width: 20,),
                            ElevatedButton(onPressed: (){
                              //Closing dialog and activity
                              Provider.of<DatabaseHelper>(context,listen:false).updateAll();
                              Provider.of<DatabaseHelper>(context,listen: false).dialogOpen = false;
                              Navigator.of(context).pop();
                            }, child: Text("Restart")),
                          ],)
                      ],
                    ),
                  ));
            }
            else {

              if(Provider.of<DatabaseHelper>(context,listen: false).dialogOpen==true){
                print("Reached");
                Provider.of<DatabaseHelper>(context,listen: false).dialogOpen = false;
                showDialog(context: context,
                    builder: (_) => AlertDialog(
                      title: Text("House No "+Provider.of<DatabaseHelper>(context,listen: false).houseInfo.houseID.toString()),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("You looked at "+Provider.of<DatabaseHelper>(context,listen: false).houseInfo.number.toString()),
                        ],
                      ),
                    ));
              }
            }
          });

          print("hello");
          return Center(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemBuilder: (context, position) {
                return new MyHouse(
                    houseId: snapshot.mainHouseModelList[position].houseId,
                    houseSubId: snapshot.mainHouseModelList[position].list,
                    visited: snapshot.mainHouseModelList[position].visited);
              },
              itemCount: snapshot.mainHouseModelList.length,
            ),
          );
        },
      ),
    );
  }
}
