import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'database/database.dart';
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
      title: 'House App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'House App'),
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
          // Check whether list is empty or not
          if (Provider.of<DatabaseHelper>(context, listen: false)
                  .mainHouseModelList
                  .length >
              0) {
            // Check all visited and show dialog on it.
            Provider.of<DatabaseHelper>(context, listen: false)
                .checkAllVisited()
                .then((value) {
              if (value == true) {
                Provider.of<DatabaseHelper>(context, listen: false).dialogOpen =
                    false;
                House houseInfo =Provider.of<DatabaseHelper>(context, listen: false).houseInfo;

                // Fetching last house and showing dialog
                            showDialog(
                                context: context,
                                // Creating alert Dialog
                                builder: (_) => AlertDialog(
                                      title: Text("House No " +
                                          houseInfo.houseID.toString()),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text("You looked at " +
                                              houseInfo.number.toString() +
                                              " houses"),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              ElevatedButton(
                                                  onPressed: () {
                                                    //Closing dialog
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text("cancel")),
                                              SizedBox(
                                                width: 20,
                                              ),
                                              ElevatedButton(
                                                  onPressed: () {
                                                    //Restarting the houses
                                                    Provider.of<DatabaseHelper>(
                                                            context,
                                                            listen: false)
                                                        .updateAll();
                                                    //Closing dialog
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text("Restart")),
                                            ],
                                          )
                                        ],
                                      ),
                                    ));

              } else {
                // dialogOpen will be true if all sub houses of house are visited.
                if (Provider.of<DatabaseHelper>(context, listen: false)
                        .dialogOpen ==
                    true) {
                  Provider.of<DatabaseHelper>(context, listen: false)
                      .dialogOpen = false;
                  showDialog(
                      context: context,
                      builder: (_) =>
                          // Showing dialog when sub houses of house are visited.
                          AlertDialog(
                            title: Text("House No " +
                                Provider.of<DatabaseHelper>(context,
                                        listen: false)
                                    .houseInfo
                                    .houseID
                                    .toString()),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text("You looked at " +
                                    Provider.of<DatabaseHelper>(context,
                                            listen: false)
                                        .houseInfo
                                        .number
                                        .toString()+" houses"),
                              ],
                            ),
                          ));
                }
              }
            });
          }
          // Creating houses on the basis of mainHouseModelList
          return Center(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemBuilder: (context, position) {
                // Creating houses
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
