import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app1/screen/houseNumberWidget.dart';
import 'package:provider/provider.dart';

import '../database/database.dart';
import '../model/database_helper_model.dart';
import '../model/house_model.dart';

// This class used for making card of house and its Sub houses.
class MyHouse extends StatefulWidget {
  final int houseId;
  final List<int> houseSubId;
  final List<bool> visited;

  MyHouse(
      {required this.houseId, required this.houseSubId, required this.visited});

  @override
  _House createState() => _House();
}

class _House extends State<MyHouse> {
  bool isForward = false;
  List<Row> rows = [];
  Column column = Column();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.houseId);
  }

  @override
  Widget build(BuildContext context) {

    isForward=false;
    rows.clear();

    // Creating Rows for house. For example house id =1 and its sub rows element are 1 to 15. So 5 rows are creating for that purpose.
    // I assume max 5 element can appear in 1 row

    rows.add(Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            "House No: " + widget.houseId.toString(),
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        )
      ],
    ));

    for (int i = 0; i < widget.houseSubId.length; i = i + 5) {
      isForward = !isForward;
      // For making row using forward arrow
      if (isForward) {
        if (widget.houseSubId.length - i >= 5) {
          Row row = Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              for (int j = i; j < i + 4; j++)
                HouseNumber(
                  houseInfo: House(
                      houseID: widget.houseId,
                      number: widget.houseSubId[j],
                      visited: widget.visited[j]),
                  color: Colors.green,
                  arrowDirection: "forward",
                ),
              if (i + 5 == widget.houseSubId.length)
                // If it is last element then no arrow will assign to it
                HouseNumber(
                  houseInfo: House(
                      houseID: widget.houseId,
                      number: widget.houseSubId[i + 4],
                      visited: widget.visited[i + 4]),
                  color: Colors.green,
                  arrowDirection: "",
                )
              else
              // Assign downward arrow to last element
                HouseNumber(
                  houseInfo: House(
                      houseID: widget.houseId,
                      number: widget.houseSubId[i + 4],
                      visited: widget.visited[i + 4]),
                  color: Colors.green,
                  arrowDirection: "downward",
                ),
            ],
          );
          // column.children.add(row);
          rows.add(row);
        } else {
          // For making row with backward arrow
          int remainingLength = widget.houseSubId.length - i;
          Row row = Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: 8,),
              for (int j = i; j < i + remainingLength - 1; j++)
                HouseNumber(
                  houseInfo: House(
                      houseID: widget.houseId,
                      number: widget.houseSubId[j],
                      visited: widget.visited[j]),
                  color: Colors.green,
                  arrowDirection: "forward",
                ),
              HouseNumber(
                houseInfo:House(
                    houseID: widget.houseId,
                    number: widget.houseSubId[i + remainingLength - 1],
                    visited: widget.visited[i + remainingLength - 1]),
                color: Colors.green,
                arrowDirection: "",
              ),
            ],
          );
          // column.children.add(row);
          rows.add(row);
        }
      } else {
        if (widget.houseSubId.length - i >= 5) {
          Row row = Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              if (i + 5 != widget.houseSubId.length)
                HouseNumber(
                  houseInfo: House(
                      houseID: widget.houseId,
                      number: widget.houseSubId[i + 4],
                      visited: widget.visited[i + 4]),
                  color: Colors.green,
                  arrowDirection: "downward",
                )
              else
                HouseNumber(
                  houseInfo: House(
                      houseID: widget.houseId,
                      number: widget.houseSubId[i + 4],
                      visited: widget.visited[i + 4]),
                  color: Colors.green,
                  arrowDirection: "",
                ),
              for (int j = i + 3; j >= i; j--)
                HouseNumber(
                  houseInfo: House(
                      houseID: widget.houseId,
                      number: widget.houseSubId[j],
                      visited: widget.visited[j]),
                  color: Colors.green,
                  arrowDirection: "backward",
                ),
            ],
          );
          // column.children.add(row);
          rows.add(row);
        } else {
          int remainingLength = widget.houseSubId.length - i;

          Row row = Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              HouseNumber(
                houseInfo: House(
                    houseID: widget.houseId,
                    number: widget.houseSubId[i + remainingLength - 1],
                    visited: widget.visited[i + remainingLength - 1]),
                color: Colors.green,
                arrowDirection: "",
              ),
              for (int j = i + remainingLength - 2; j >= i; j--)
                // j==i?Container(
                //   margin: EdgeInsets.only(left: 10),
                //   child: HouseNumber(
                //     houseInfo: House(
                //         houseID: widget.houseId,
                //         number: widget.houseSubId[j],
                //         visited: widget.visited[j]),
                //     color: Colors.green,
                //     arrowDirection: "backward",
                //   ),
                // ):
                HouseNumber(
                  houseInfo: House(
                  houseID: widget.houseId,
                  number: widget.houseSubId[j],
                  visited: widget.visited[j]),
                  color: Colors.green,
                  arrowDirection: "backward",
                  ),
            ],
          );
          // column.children.add(row);
          rows.add(row);
        }
      }
    }

    print("Build called");
    return Container(
          child: Card(
        color: Colors.white,
            child: Column(
          children: [
            for(Row temp in rows)
              temp
          ],
        ),
      ));
    }
}
