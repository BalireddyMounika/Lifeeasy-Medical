import 'package:intl/intl.dart';

List<String> monthsList = [
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'May',
  'Jun',
  'Jul',
  'Aug',
  'Sep',
  'Oct',
  'Nov',
  'Dec'
];

String formatDate(String date) {
  var parsedDate = DateTime.parse(date);
  //var formattedDate =  DateFormat('dd-MM-yyyy').format(parsedDate);
  var month = parsedDate.month;
  var currentMonth = monthsList[month-1];

  return "${parsedDate.day.toString()} $currentMonth ${parsedDate.year.toString()}";
}

extension something on DateTime
{
   String formatDate(String date) {
    var parsedDate =  DateTime.parse(date);
    //var formattedDate =  DateFormat('dd-MM-yyyy').format(parsedDate);
    var month = parsedDate.month;
    var currentMonth = monthsList[month-1];

    return "${parsedDate.day.toString()} $currentMonth ${parsedDate.year.toString()}";
  }

}