import 'package:flutter/material.dart';



import 'House.dart';
import 'model/DatabaseHelperModel.dart';
import 'model/appbar.dart';

void main() {
  runApp(MyApp());
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
  Widget build(BuildContext context) {
    DatabaseHelper databaseHelper = new DatabaseHelper();
    databaseHelper.initializeDatabases();

    return Scaffold(
      appBar: StandardAppBar(
        title: "",
      ),
      body: Center(
        child: ListView.builder(
          itemBuilder: (context, position) {
            return MyHouse(houseId: databaseHelper.mainHouseModelList[position].houseId,houseSubId:databaseHelper.mainHouseModelList[position].list,visited: databaseHelper.mainHouseModelList[position].visited );
          },
          itemCount: databaseHelper.mainHouseModelList.length,
        ),
      ),
    );
  }
}
