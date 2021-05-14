class Event {
  int year, date;
  String month, event, eventDescrp;
  List<EventData> eventList;

  Event({this.year, this.date, this.month, this.event, this.eventDescrp});


  Map<String, dynamic> toMap() {
    return {
      'year': year,
      'date': date,
      'month': month,
      'eventTitle': event,
      'eventDesc': eventDescrp,
    };
  }


   Event.fromJson(dynamic json){
     print("JSON: $json");
    eventList= new List<EventData>();
    json.forEach((v) {
      print("JSON: $v");
      eventList.add(new EventData.fromJson(v));
      print("LENGTH: ${eventList[0].year}");
    });



}


}
class EventData{
  int year, date;
  String month, event, eventDescrp;


  EventData({this.year, this.date, this.month, this.event, this.eventDescrp});
  factory EventData.fromJson(dynamic json) {
    return EventData(
      year: json["year"],
      month: json["month"],
      date: json["date"],
      event: json["eventTitle"],
      eventDescrp: json["eventDesc"]

    );
  }

}