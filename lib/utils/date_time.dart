import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

DateTime? dateTimeFromTimeStamp({required Timestamp? time}) {
  return time != null ? DateTime.fromMicrosecondsSinceEpoch(time.microsecondsSinceEpoch) : null;
}

String formatDate({required DateTime? datetime, required String? dateFormat}) {
  return (datetime != null && dateFormat != null) ? DateFormat(dateFormat).format(datetime) : '';
}

String getDateOrTime({required DateTime? datetime}) {
  if (datetime == null) {
    return '';
  }
  if (datetime.day == DateTime.now().day) {
    return formatDate(datetime: datetime, dateFormat: 'HH:mma');
  }
  int difference = DateTime.now().day - datetime.day;
  if (difference == 1) {
    return 'Yesterday';
  }
  return '$difference days ago';
}
