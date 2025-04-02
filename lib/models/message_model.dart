import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:simple_chat/utils/date_time.dart';
import 'package:simple_chat/utils/map_extensions.dart';

class MessageModel {
  MessageModel({
    required this.id,
    required this.dateTimeCreated,
    this.text = '',
    this.authorId = '',
    this.chatId = '',
  });

  factory MessageModel.fromFirebase({required DocumentSnapshot snapshot}) {
    final Map<String, dynamic> map = snapshot.data()! as Map<String, dynamic>;
    return MessageModel(
      id: snapshot.id,
      text: map.getValueOrDefault<String>('text', ''),
      authorId: map.getValueOrDefault<String>('authorId', ''),
      chatId: map.getValueOrDefault<String>('chatId', ''),
      dateTimeCreated: dateTimeFromTimeStamp(
          time: map.getValueOrNull<Timestamp>('dateTimeCreated')),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'text': text,
      'authorId': authorId,
      'chatId': chatId,
      'dateTimeCreated': dateTimeCreated?.toIso8601String(),
    };
  }

  String id;
  String text;
  String authorId;
  String chatId;
  DateTime? dateTimeCreated;
}
