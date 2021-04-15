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


  List<int> list = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15];
  int houseId = 0;
  List<bool> visited = [
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true
  ];


  @override
  Widget build(BuildContext context) {
    DatabaseHelper databaseHelper = new DatabaseHelper();
    databaseHelper.initializeDatabases();

    return Scaffold(
      appBar: StandardAppBar(
        title: "",
      ),
      body: Center(
        child: House(
          visited: this.visited,
          houseId: this.houseId,
          houseSubId: this.list,
        ),
      ),
    );
  }
}
