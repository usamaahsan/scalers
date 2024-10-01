String getTimePosted(String date){

  List<String> split = date.split("-");
  int year = int.parse(split[0]);
  int month = int.parse(split[1]);
  int day = int.parse(split[2]);

  DateTime createdDateTime = DateTime(year,month,day);
  DateTime now = DateTime.now();

  int daysBeforePosted = now.difference(createdDateTime).inDays;
  String datePosted = "$daysBeforePosted days ago";

  return datePosted;
}