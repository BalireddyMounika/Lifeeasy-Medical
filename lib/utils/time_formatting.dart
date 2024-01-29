
String formatTime(String time)
{
  var convertedTimeToInt =  int.parse(time);
  if(convertedTimeToInt>12)
    convertedTimeToInt = convertedTimeToInt -12;

  return convertedTimeToInt.toString();
}