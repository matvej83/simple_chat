import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:simple_chat/models/user.dart';
import 'package:simple_chat/utils/date_time.dart';
import 'package:simple_chat/utils/map_extensions.dart';

class ChatModel {
  ChatModel({
    required this.id,
    required this.dateTimeCreated,
    this.name = '',
    this.participantsIds = const <String>[],
    this.participantsDetails = const <UserModel>[],
    this.lastMessaged,
    this.lastMessageId,
  });

  factory ChatModel.fromFirebase({required DocumentSnapshot snapshot}) {
    final Map<String, dynamic> map = snapshot.data()! as Map<String, dynamic>;
    return ChatModel(
      id: snapshot.id,
      name: map.getValueOrDefault<String>('name', ''),
      dateTimeCreated: dateTimeFromTimeStamp(
          time: map.getValueOrNull<Timestamp>('dateTimeCreated')),
      participantsIds: map.getValueOrDefault<List>('participantsIds', []),
      participantsDetails: map.containsKey('participantsDetails')
          ? List<UserModel>.from(map['participantsDetails']
              .map((x) => UserModel.fromMap(map: x as Map<String, dynamic>))
              .toList() as List)
          : [],
      lastMessaged: dateTimeFromTimeStamp(
          time: map.getValueOrNull<Timestamp>('lastMessaged')),
      lastMessageId: map.getValueOrDefault('lastMessageId', ''),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'dateTimeCreated': dateTimeCreated?.toIso8601String(),
      'participantsIds': participantsIds,
      'participantsDetails': participantsDetails,
      'lastMessageId': lastMessageId,
    };
  }

  String id;
  String name;
  DateTime? dateTimeCreated;
  List participantsIds;
  List<UserModel> participantsDetails;
  DateTime? lastMessaged;
  String? lastMessageId;
}
