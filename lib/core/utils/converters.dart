import 'package:cloud_firestore/cloud_firestore.dart';

class Converters {
  // Converts Timestamp to DateTime
  static DateTime? intToDateTime(int? millisecondsSinceEpoch) =>
      DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch ?? 0);

  // // Converts DateTime to Timestamp
  // static Timestamp? dateTimeToTimestamp(DateTime? dateTime) =>
  //     dateTime == null ? null : Timestamp.fromDate(dateTime);

  static int? dateTimeToInt(DateTime? dateTime) =>
      dateTime?.millisecondsSinceEpoch;
}
