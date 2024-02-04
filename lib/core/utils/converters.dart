import 'package:cloud_firestore/cloud_firestore.dart';

class Converters {
  // Converts Timestamp to DateTime
  static DateTime timestampToDateTime(Timestamp? timestamp) =>
      timestamp?.toDate() ?? DateTime.now();

  // Converts DateTime to Timestamp
  static Timestamp dateTimeToTimestamp(DateTime? dateTime) =>
      Timestamp.fromDate(dateTime ?? DateTime.now());
}
