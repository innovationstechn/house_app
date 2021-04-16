import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app1/houseSubCategoryPage.dart';
import 'database/database.dart';

class HouseNumber extends StatefulWidget {
  final String arrowDirection;
  final Color color;
  final House houseInfo;

  HouseNumber(
      {required this.houseInfo,
      required this.color,
      required this.arrowDirection});

  @override
  _HouseNumber createState() => _HouseNumber();
}

class _HouseNumber extends State<HouseNumber> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: widget.arrowDirection == "downward" ? 40 : 70,
      child: Column(
        children: [
          Row(
            children: [
              widget.arrowDirection == "backward"
                  ? Icon(IconData(0xe5a7,
                      fontFamily: 'MaterialIcons', matchTextDirection: true))
                  : SizedBox(
                      width: 0,
                      height: 0,
                    ),
              Container(
                  height: 40,
                  width: 40,
                  child: Center(
                      child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HouseSubCategoryPage(
                                        houseInfo: widget.houseInfo)));
                          },
                          child: Text(
                            widget.houseInfo.number.toString(),
                            style: TextStyle(fontSize: 30, color: Colors.white),
                          ))),
                  decoration: new BoxDecoration(
                    color: widget.houseInfo.visited == false
                        ? widget.color
                        : Colors.red,
                    shape: BoxShape.circle,
                    border: Border.all(width: 1),
                  )),
              widget.arrowDirection == "forward"
                  ? Icon(IconData(58799,
                      fontFamily: 'MaterialIcons', matchTextDirection: true))
                  : SizedBox(
                      width: 0,
                      height: 0,
                    ),
            ],
          ),
          widget.arrowDirection == "downward"
              ? Icon(IconData(58795,
                  fontFamily: 'MaterialIcons', matchTextDirection: true))
              : SizedBox(
                  width: 0,
                  height: 0,
                ),
        ],
      ),
    );
  }
}
