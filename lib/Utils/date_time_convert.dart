import 'package:date_format/date_format.dart';

final List<String> initFormat = [yyyy, '-', mm, '-', dd, ' ', HH, ':', nn, ':', ss];

DateTime convertMillisecondsToDateTime(int ms) {
  if (ms == null) return null;
  return DateTime.fromMillisecondsSinceEpoch(ms);
}

int convertDateStringToMilliseconds(String dateString, {datePattern = '-', timePattern = ":"}) {
  if (dateString == null || dateString == "") return null;

  return convertDateStringToDateTime(dateString).millisecondsSinceEpoch;
}

String convertMillisecondsToDateString(int ms, {List<String> formats}) {
  if (formats == null || formats.length == 0) formats = initFormat;
  DateTime dateTime = convertMillisecondsToDateTime(ms);
  return convertDateTimeToDateString(dateTime, formats: formats);
}

String convertDateTimeToDateString(DateTime dt, {List<String> formats}) {
  if (formats == null || formats.length == 0) formats = initFormat;
  return formatDate(dt, formats);
}

DateTime convertDateStringToDateTime(String strDate, {datePattern = '-', timePattern = ":"}) {
  if (strDate == "" || strDate == null) return null;

  List<String> listDateTime = strDate.split(" ");
  List<String> listDate = listDateTime[0].split(datePattern);
  List<String> listTime = (listDateTime.length == 2) ? listDateTime[1].split(timePattern) : null;

  return DateTime(
    int.parse((listDate != null && listDate.length >= 1 && listDate[0] != "") ? listDate[0].toString() : "0"),
    int.parse((listDate != null && listDate.length >= 2 && listDate[1] != "") ? listDate[1].toString() : "0"),
    int.parse((listDate != null && listDate.length >= 3 && listDate[2] != "") ? listDate[2].toString() : "0"),
    int.parse((listTime != null && listTime.length >= 1 && listTime[0] != "") ? listTime[0].toString() : "0"),
    int.parse((listTime != null && listTime.length >= 2 && listTime[1] != "") ? listTime[1].toString() : "0"),
    int.parse((listTime != null && listTime.length >= 3 && listTime[2] != "") ? listTime[2].toString() : "0"),
  );
}

String getDateItemFromDateString(String strDate, List<String> formats, {datePattern = '-', timePattern = ":"}) {
  if (formats == null || formats.length == 0) formats = initFormat;

  DateTime dateTime = convertDateStringToDateTime(strDate);
  return convertDateTimeToDateString(dateTime, formats: formats);
}
