import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app1/houseNumberWidget.dart';
import 'package:flutter_app1/model/SubCategoryHouseModel.dart';


class House extends StatefulWidget {

  final int houseId;
  final List<int> houseSubId;
  final List<bool> visited;

  House({this.houseId,this.houseSubId,this.visited});

  @override
  _House createState() => _House();
}

class _House extends State<House> {

  bool isForward=false;
  List<Row> rows=[];
  Column column;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("initState");

    rows.add(Row(children: [Padding(
      padding: const EdgeInsets.all(10.0),
      child: Text("House No: " + widget.houseId.toString(),style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
    )],));

    for(int i=0;i<widget.houseSubId.length;i=i+5)
    {
      isForward=!isForward;
      if(isForward){

        if(widget.houseSubId.length-i>=5)
        {

          Row row= Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              for(int j=i;j<i+4;j++)
                HouseNumber(houseInfo: SubCategoryHouseModel( houseId: widget.houseId,number: widget.houseSubId[j],visited:widget.visited[j]),color: Colors.green,arrowDirection: "forward",),
               if(i+5==widget.houseSubId.length)
                  HouseNumber(houseInfo:SubCategoryHouseModel(houseId: widget.houseId,number: widget.houseSubId[i+4],visited:widget.visited[i+4]),color: Colors.green,arrowDirection: "",)
               else
               HouseNumber(houseInfo:SubCategoryHouseModel(houseId: widget.houseId,number: widget.houseSubId[i+4],visited:widget.visited[i+4]),color: Colors.green,arrowDirection: "downward",),
            ],
          );
          // column.children.add(row);
          rows.add(row);
        }
        else
        {
            int remainingLength = widget.houseSubId.length-i;
            Row row= Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  for(int j=i;j<i+remainingLength-1;j++)
                    HouseNumber(houseInfo: SubCategoryHouseModel(houseId: widget.houseId,number: widget.houseSubId[j],visited:widget.visited[j]),color: Colors.green,arrowDirection: "forward",),
                    HouseNumber(houseInfo:SubCategoryHouseModel(houseId: widget.houseId,number: widget.houseSubId[i+remainingLength-1],visited:widget.visited[i+remainingLength-1]),color: Colors.green,arrowDirection: "",),
          ],);
            // column.children.add(row);
            rows.add(row);
        }
      }
      else {

        if(widget.houseSubId.length-i>=5)
        {
          Row row= Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              if(i+5!=widget.houseSubId.length)
              HouseNumber(houseInfo: SubCategoryHouseModel(houseId: widget.houseId,number: widget.houseSubId[i+4],visited:widget.visited[i+4]),color: Colors.green,arrowDirection: "downward",)
              else
                HouseNumber(houseInfo:SubCategoryHouseModel(houseId: widget.houseId,number: widget.houseSubId[i+4],visited:widget.visited[i+4]),color: Colors.green,arrowDirection: "",),
              for(int j=i+3;j>=i;j--)
                HouseNumber(houseInfo:SubCategoryHouseModel(houseId: widget.houseId,number: widget.houseSubId[j],visited:widget.visited[j]),color: Colors.green,arrowDirection: "backward",),
            ],
          );
          // column.children.add(row);
          rows.add(row);
        }
        else
        {
          int remainingLength = widget.houseSubId.length-i;

          Row row= Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              HouseNumber(houseInfo:SubCategoryHouseModel(houseId: widget.houseId,number: widget.houseSubId[i+remainingLength-1],visited:widget.visited[i+remainingLength-1]),color: Colors.green,arrowDirection: "",),
              for(int j=i+remainingLength-2;j>=i;j--)
                HouseNumber(houseInfo:SubCategoryHouseModel(houseId: widget.houseId,number: widget.houseSubId[j],visited:widget.visited[j]),color: Colors.green,arrowDirection: "backward",),
            ],
          );
          // column.children.add(row);
          rows.add(row);
        }
      }
    }
  }


  @override
  Widget build(BuildContext context) {

    return Container(
      child: Card(
        color: Colors.white,
        child: ListView.builder(
          itemBuilder: (context, position) {
            return Container(
                child: position==0?Container(margin:EdgeInsets.only(bottom:10),color:Colors.black12,child: rows[position]):rows[position],
            );
          },
          itemCount: rows.length,
        ),
      )

    );
  }
}


