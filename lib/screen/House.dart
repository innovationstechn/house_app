import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../database/database.dart';
import 'houseNumberWidget.dart';

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

  // Used For Making Row with Forward arrow
  void loadForward(int i){

    // Creating a row with forward arrow if we have remaining houses length>=5
    if (widget.houseSubId.length - i >= 5) {
      Row row = Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Using a forward arrow with four number
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
          // If the current number is the last sub house then don't apply arrow
            HouseNumber(
              houseInfo: House(
                  houseID: widget.houseId,
                  number: widget.houseSubId[i + 4],
                  visited: widget.visited[i + 4]),
              color: Colors.green,
              arrowDirection: "",
            )
          else
          // If the current number is not the last sub house then apply downward arrow with it.
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

      // Creating a row with forward arrow if we have remaining houses length<5
      int remainingLength = widget.houseSubId.length - i;
      Row row = Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Using forward arrow for first elements
          for (int j = i; j < i + remainingLength - 1; j++)
            HouseNumber(
              houseInfo: House(
                  houseID: widget.houseId,
                  number: widget.houseSubId[j],
                  visited: widget.visited[j]),
              color: Colors.green,
              arrowDirection: "forward",
            ),
          // Current number is the last sub house so don't apply any arrow
          HouseNumber(
            houseInfo:House(
                houseID: widget.houseId,
                number: widget.houseSubId[i + remainingLength - 1],
                visited: widget.visited[i + remainingLength - 1]),
            color: Colors.green,
            arrowDirection: "",
          ),
          // Fill space for number not present in a row
          for (int j = 0; j < 5 - remainingLength; j++)
            Container(color: Colors.transparent,width: 70,)
        ],
      );
      // column.children.add(row);
      rows.add(row);
    }

  }

  // Used For Making Row with Backward arrow
  void loadBackward(int i){

    // Creating a row with backward arrow if we have remaining houses length>=5
    if (widget.houseSubId.length - i >= 5) {
      Row row = Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // If the current number is not the last sub house then apply downward arrow with it.(Apply to the first element in a row)
          if (i + 5 != widget.houseSubId.length)
            Container(
              child: HouseNumber(
                houseInfo: House(
                    houseID: widget.houseId,
                    number: widget.houseSubId[i + 4],
                    visited: widget.visited[i + 4]),
                color: Colors.green,
                arrowDirection: "downward",
              ),
            )
          else
          // Current number is the last sub house then don't apply arrow
            HouseNumber(
              houseInfo: House(
                  houseID: widget.houseId,
                  number: widget.houseSubId[i + 4],
                  visited: widget.visited[i + 4]),
              color: Colors.green,
              arrowDirection: "",
            ),
          // Creating backward arrow with last 4 elements in a row
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
      // Creating a row with backward arrow if we have remaining houses length<5

      //Calculate remaining elements
      int remainingLength = widget.houseSubId.length - i;
      Row row = Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Fill space for number not present in a row
          for (int j = 0; j < 5 - remainingLength; j++)
            Container(color: Colors.transparent,width: 70,),
          //Don't assign arrow to last element.
          HouseNumber(
            houseInfo: House(
                houseID: widget.houseId,
                number: widget.houseSubId[i + remainingLength - 1],
                visited: widget.visited[i + remainingLength - 1]),
            color: Colors.green,
            arrowDirection: "",
          ),
          //Apply backward arrow to other elements in a row.
          for (int j = i + remainingLength - 2; j >= i; j--)
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
      rows.add(row);
    }

  }

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

    // Creating Rows for house. For example house id =1 and its sub houses element are 1 to 15. So 5 rows are creating for that purpose.
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
        loadForward(i);
      } else {
        //Making row using backward arrow
        loadBackward(i);
      }
    }

    // Placing rows in a card
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
