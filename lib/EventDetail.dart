import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:snapwork_interview/Database/EventDB.dart';
import 'Model/Event.dart';

class EventDetail extends StatefulWidget {
  String month;
  int year,date;
  EventDetail (String month,int year,int date){
    this.date=date;
    this.month=month;
    this.year=year;
  }

  _EventDetailState createState() => _EventDetailState();

}

class _EventDetailState extends State<EventDetail> {
  final eventTitleController = TextEditingController();
  final eventDesController = TextEditingController();

  @override
  void initState() {
    EventDB.database();
    super.initState();
  }
  @override
  void dispose() {
    eventTitleController.dispose();
    eventDesController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
          Navigator.of(context).pop(true);
          return ;
    },

      child: SafeArea(
        child: MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(title: Text("Events"),centerTitle:true,backgroundColor: Colors.blue[800],),
            body: Padding(
              padding:  EdgeInsets.only(top:10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding:  EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Align(alignment:Alignment.center,child: Text('Date & Time', style: TextStyle(
                            fontSize: 18,
                            fontFamily: "PlayfairDisplay",
                            color: Colors.black
                        ))),
                        SizedBox(width: 10,),

                        Container(
                          width: 100,
                          height: 40,
                          child: TextField(

                            cursorColor: Colors.grey,
                            autocorrect: true,
                            decoration: InputDecoration(
                              hintText: 'HH:MM',
                              hintStyle: TextStyle(
                                  fontSize: 16,
                                  fontFamily: "PlayfairDisplay",
                                  color: Colors.grey
                              ),
                              filled: true,
                              fillColor: Colors.white70,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(12.0)),
                                borderSide: BorderSide(color: Colors.grey[300], width: 2),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide(color: Colors.grey[300]),
                              ),
                            ),),

                        ),
                        SizedBox(width: 10,),
                        Align(alignment:Alignment.center,child: Text('${widget.date} ${widget.month} ${widget.year}', style: TextStyle(
                            fontSize: 15,
                            fontFamily: "PlayfairDisplay",
                            color: Colors.black
                        ))),
                      ],
                    ),
                  ),
                  Padding(
                    padding:  EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Align(alignment:Alignment.center,child: Text('Title', style: TextStyle(
                            fontSize: 18,
                            fontFamily: "PlayfairDisplay",
                            color: Colors.black
                        ))),
                        SizedBox(width: 20,),
                        Expanded(
                          flex: 1,
                          child: Container(
                            height: 50,
                            child: TextField(
                              controller: eventTitleController,
                              cursorColor: Colors.grey,
                              autocorrect: true,
                              decoration: InputDecoration(
                                hintText: 'Event Title...',
                                hintStyle: TextStyle(color: Colors.grey),
                                filled: true,
                                fillColor: Colors.white70,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                                  borderSide: BorderSide(color: Colors.grey[300], width: 2),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                  borderSide: BorderSide(color: Colors.grey[300]),
                                ),
                              ),),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding:  EdgeInsets.all(10),
                    child:Align(alignment:Alignment.topLeft,child: Text('Description', style: TextStyle(
                        fontSize: 18,
                        fontFamily: "PlayfairDisplay",
                        color: Colors.black
                    ))),
                  ),

                  Padding(
                    padding:  EdgeInsets.all(10),
                    child:  Container(

                      color: Colors.grey[200],
                      child: TextField(
                        controller: eventDesController,
                        maxLines: 4,
                        cursorColor: Colors.grey,


                        decoration: InputDecoration(


                          hintText: 'Event Description...',
                          hintStyle: TextStyle(color: Colors.grey),
                          filled: true,
                          fillColor: Colors.grey[200],
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey[300]),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey[300], width: 2),
                          ),

                        ),),
                    ),
                  ),

                  Expanded(flex:1,child:   Center(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: 20,
                                bottom: 10,
                                left: 20,
                                right: 20),
                            child: Container(
                              width: double.infinity,
                              height: 45,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(25.0),
                                ),
                              ),
                              child: FlatButton(
                                onPressed: () async {
                                  print("${eventTitleController.text.length}");
                                  if(eventTitleController.text.length>0 && eventDesController.text.length>0){
                                    EventDB().createOrUpdateObject(Event(year:widget.year,date:widget.date,month:"${widget.month}",event:"${eventTitleController.text}",eventDescrp:"${eventDesController.text}"));
                                    EventDB().eventList();
                                    Navigator.pop(context);
                                  }
                                  else{
                                    return Fluttertoast.showToast(
                                      msg: 'Please enter the event details',
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.SNACKBAR,
                                      backgroundColor: Colors.blueGrey,
                                      textColor: Colors.white,
                                      fontSize: 16.0,
                                    );
                                  }

                                  },
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        color: Colors.blue[800],
                                        width: 1,
                                        style: BorderStyle.solid),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10.0))),
                                child: Text(
                                  'SAVE',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 15),
                                ),
                                color: Colors.blue[800],
                              ),
                            ),
                          ),
                        ),
                      )))








                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}