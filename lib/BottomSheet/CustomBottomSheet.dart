
import 'package:flutter/material.dart';

class CustomBottomSheet{

  int year;
  String month;
  var initialYear =DateTime(2016);
  var endYear =DateTime(2025);
  List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];




  Future<int> getYearsBottomSheet(BuildContext context) async
   {
     print("Difference: ${endYear.year- initialYear.year}");
    await showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      context: context,
      builder: (BuildContext context) {
        return MediaQuery(
          data:MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: Container(
              padding: EdgeInsets.only(bottom: 20),
              height:double.maxFinite,
              child: StatefulBuilder(
                builder: (BuildContext context, StateSetter state) {
                  return Column(
                    children: <Widget>[
                      Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: endYear.year- initialYear.year,
                          itemBuilder: (context, int index) {
                            return Column(
                              children: <Widget>[
                                InkWell(
                                  onTap:(){
                                    state((){
                                      year=initialYear.year+index;
                                    });
                                    Navigator.of(context).pop();
                                 },
                                  child: Container(
                                    height:50,
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text("${initialYear.year+index}",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              fontFamily: "Helvetica",
                                              color: Colors.blue[900],
                                              fontSize: 20)),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 5,
                                  padding: EdgeInsets.only(
                                      bottom: 20, left: 15, right: 10),
                                  child: Divider(),
                                ),

                              ],
                            );
                          },
                        ),
                      ),

                    ],
                  );
                },
              )),
        );
      },

    );
    return year;
     }

  Future<String>geMonthsBottomSheet(BuildContext context) async
   {
    await showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      context: context,
      builder: (BuildContext context) {
        return MediaQuery(
          data:MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: Container(
              padding: EdgeInsets.only(bottom: 20),
              height:double.maxFinite,
              child: StatefulBuilder(
                builder: (BuildContext context, StateSetter state) {
                  return Column(
                    children: <Widget>[
                      Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: months.length,
                          itemBuilder: (context, int index) {
                            return Column(
                              children: <Widget>[
                            InkWell(
                               onTap:()
                            {
                              state(() {
                                month = months[index];
                              });
                              Navigator.of(context).pop();
                            },
                                  child: Container(
                                    height:50,
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text("${months[index]}",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              fontFamily: "Helvetica",
                                              color: Colors.blue[900],
                                              fontSize: 20)),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 5,
                                  padding: EdgeInsets.only(
                                      bottom: 20, left: 15, right: 10),
                                  child: Divider(),
                                ),

                              ],
                            );
                          },
                        ),
                      ),

                    ],
                  );
                },
              )),
        );
      },
    );
    return month;
     }
}