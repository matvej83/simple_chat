import 'package:flutter/material.dart';
import 'package:simple_chat/models/chat_model.dart';
import 'package:simple_chat/models/user.dart';

class ChatProvider with ChangeNotifier {
  List<ChatModel> chats = [];
  List<ChatModel> selectedChats = [];
  List<UserModel> users = [];
  String pattern = '';
  Map<String, UserModel> usersMap = {};

  void setChatsList({required List<ChatModel> chats}) {
    this.chats = chats;
    if (pattern.isEmpty) {
      selectedChats = chats;
    }
    notifyListeners();
  }

  void startSearch({required String pattern}) {
    this.pattern = pattern;
    if (pattern.isNotEmpty) {
      selectedChats = chats
          .where((element) =>
              element.name.toLowerCase().contains(pattern.toLowerCase()))
          .toList();
    } else {
      selectedChats = chats;
    }
    notifyListeners();
  }

  void setUsersList({required List<UserModel> users}) {
    this.users = users;
    users.forEach((element) {
      usersMap[element.id] = element;
    });
    notifyListeners();
  }
}
