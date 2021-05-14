

import 'package:date_util/date_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:snapwork_interview/BottomSheet/CustomBottomSheet.dart';

import 'Database/EventDB.dart';
import 'EventDetail.dart';
import 'Model/Event.dart';

class HomePage extends StatefulWidget {

  _HomePageState createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> {

  String finalDate = '';
  var date;
  var totalDays;
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
  int currentNoDays,year;
  String month;
  var  dateUtility = DateUtil();
  String description;

  @override
  void initState() {
    EventDB.database();
    year=DateTime.parse(new DateTime.now().toString()).year;
    month=months[DateTime.parse(new DateTime.now().toString()).month-1];

    currentNoDays = dateUtility.daysInMonth(DateTime.parse(new DateTime.now().toString()).month, DateTime.parse(new DateTime.now().toString()).year);

    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        child: Scaffold(
          appBar: AppBar(title: Text("Events",),centerTitle:true,backgroundColor: Colors.blue[800],),
            body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding:  EdgeInsets.only(top:10.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                     Padding(
                        padding: const EdgeInsets.only(left:10.0,right:10,top:10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () async{
                                int selectedYear=await CustomBottomSheet().getYearsBottomSheet(context);

                               setState(() {
                                 year= selectedYear;
                                 currentNoDays = dateUtility.daysInMonth(months.indexOf(month)+1, year);


                               });
                               print("YEAR: $year");
                              },
                              child: ClipRRect(
                                  borderRadius: BorderRadius.only(topRight: Radius.circular(15),bottomRight: Radius.circular(15),topLeft: Radius.circular(15),bottomLeft: Radius.circular(15)),
                                child: Container(
                                    height: 40,
                                    width: MediaQuery.of(context).size.width/2.3,
                                    color: Colors.blue[800],
                                    child: Align(alignment:Alignment.center,child: Text('${year}', style: TextStyle(
                                fontSize: 18,
                                fontFamily: "PlayfairDisplay",
                                    color: Colors.white
                                )))
                          ),
                          ),
                            ),
                            SizedBox(width: 10,),
                            InkWell(
                              onTap: ()async{

                                  String selectedMonth=await CustomBottomSheet().geMonthsBottomSheet(context);
                                  setState(() {
                                    month= selectedMonth;
                                    currentNoDays = dateUtility.daysInMonth(months.indexOf(month)+1, year);
                                  });
                                },


                              child: ClipRRect(
                                borderRadius: BorderRadius.only(topRight: Radius.circular(15),bottomRight: Radius.circular(15),topLeft: Radius.circular(15),bottomLeft: Radius.circular(15)),
                                child: Container(
                                  height: 40,
                                  width: MediaQuery.of(context).size.width/2.3,
                                  color: Colors.blue[800],
                                  child: Align(alignment:Alignment.center,child: Text('${month}', style: TextStyle(
                                          fontSize: 18,
                                          fontFamily: "PlayfairDisplay",
                                          color: Colors.white
                                          )))
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding:  EdgeInsets.only(top:10,left: 10,right:10,bottom: 30),
                        child: ListView.builder(
                            physics:NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: currentNoDays,
                            itemBuilder: (BuildContext context,index){
                              EventDB().getEventDetails(year, month, index+1);

                              return IntrinsicHeight(
                                child: Column(
                                  children: [
                                    InkWell(
                                      onTap: (){
                                        Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
                                          return EventDetail("$month", year,index+1);
                                        }));
                                      },
                                      child: IntrinsicHeight(
                                        child: Row(
                                          children: [
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:  EdgeInsets.only(top:10.0,left: 10),
                                                  child: Text("${index+1}",style: TextStyle(fontFamily: "PlayfairDisplay",fontSize: 13,color: Colors.black),),
                                                ),
                                                Padding(
                                                  padding:  EdgeInsets.only(top:10.0,left: 10),
                                                  child: Text("$month",style: TextStyle(fontFamily: "PlayfairDisplay",fontSize: 13,color: Colors.black),),
                                                ),

                                              ],
                                            ),

                                            VerticalDivider(color: Colors.grey[300],
                                              thickness: 2, width: 20,
                                              indent: 5,
                                              endIndent: 5,),


                                            Event().eventList!=null? Padding(
                                              padding:  EdgeInsets.only(top:10.0,left: 10),
                                              child: Text("${Event().eventList[Event().eventList.indexWhere((element) => element.date==index+1)].event}",style: TextStyle(fontFamily: "PlayfairDisplay",fontSize: 13,color: Colors.black),),
                                            ):Padding(
                                              padding:  EdgeInsets.only(top:10.0,left: 10),
                                              child: Text("",style: TextStyle(fontFamily: "PlayfairDisplay",fontSize: 13,color: Colors.black),),
                                            ),

                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: Divider(color: Colors.grey[200],
                                        thickness: 2,
                                        indent: 5,
                                        endIndent: 5,),
                                    ),
                                  ],
                                ),
                              );

                            }),
                      ),



                    ],
                  ),
              ),
            ),
            ),
      ),
    );
  }
}