import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:simple_chat/utils/map_extensions.dart';

class UserModel extends Equatable {
  const UserModel({
    required this.id,
    this.email = '',
    this.name = '',
    this.imageUrl = '',
  });

  factory UserModel.fromMap({
    required Map<String, dynamic> map,
  }) {
    return UserModel(
      id: map.getValueOrDefault<String>('id', ''),
      email: map.getValueOrDefault<String>('email', ''),
      name: map.getValueOrDefault<String>('name', ''),
      imageUrl: map.getValueOrDefault<String>('imageUrl', ''),
    );
  }

  factory UserModel.fromFirebase({
    required DocumentSnapshot doc,
  }) {
    Map<String, dynamic> map = doc.data() as Map<String, dynamic>;
    return UserModel(
      id: doc.id,
      email: map.getValueOrDefault<String>('email', ''),
      name: map.getValueOrDefault<String>('name', ''),
      imageUrl: map.getValueOrDefault<String>('imageUrl', ''),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'imageUrl': imageUrl,
    };
  }

  final String id;
  final String email;
  final String name;
  final String imageUrl;

  @override
  List<Object> get props => [id, email, name, imageUrl];

  static const empty = UserModel(id: '', name: '', email: '', imageUrl: '');
}
