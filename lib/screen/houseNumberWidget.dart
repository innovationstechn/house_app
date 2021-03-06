import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:house_app/screen/houseSubCategoryPage.dart';
import '../database/database.dart';

// This class helps in making the customize number with arrow for making rows.
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

// Creating customize number with arrow for making rows.
class _HouseNumber extends State<HouseNumber> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      // If we have arrow is in downward direction then width should be according to the size of number container
      width:  widget.arrowDirection == "downward" || widget.arrowDirection =="" ? 40 : 70,
      child: Column(
        children: [
          Row(
            children: [
              // Creating backward arrow place at the right of the number.
              widget.arrowDirection == "backward"
                  ? Container(
                    margin: EdgeInsets.only(left:10),
                    child: const Icon(IconData(0xe5a7,
                        fontFamily: 'MaterialIcons', matchTextDirection: true,),size: 20.0),
                  )
                  : SizedBox(
                      width: 0,
                      height: 0,
                    ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      // Navigating to the SubHouseCategory page for showing dummy houses and OK confirmation
                      MaterialPageRoute(
                          builder: (context) => HouseSubCategoryPage(
                              houseInfo: widget.houseInfo)));
                },
                // Creating number with circular container
                child: Container(
                    height: 40,
                    width: 40,
                    child: Center(
                        child: Text(
                          widget.houseInfo.number.toString(),
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        )),
                    decoration: new BoxDecoration(
                      color: widget.houseInfo.visited == false
                          ? widget.color
                          : Colors.red,
                      shape: BoxShape.circle,
                      border: Border.all(width: 1),
                    )),
              ),
              // Creating Forward arrow place at the left of number container.
              widget.arrowDirection == "forward"
                  ? const Icon(IconData(58799,
                      fontFamily: 'MaterialIcons', matchTextDirection: true),size: 20.0)
                  : SizedBox(
                      width: 0,
                      height: 0,
                    ),
            ],
          ),
          // Creating downward arrow place at the bottom of number.
          widget.arrowDirection == "downward"
              ? const Icon(IconData(58795,
                  fontFamily: 'MaterialIcons', matchTextDirection: true),size: 20.0)
              : SizedBox(
                  width: 0,
                  height: 0,
                ),
        ],
      ),
    );
  }
}
