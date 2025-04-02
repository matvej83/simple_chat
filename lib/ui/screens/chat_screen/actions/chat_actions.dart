import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:simple_chat/models/user.dart';
import 'package:simple_chat/repositories/user_repository.dart';

mixin ChatActions {
  Future<DocumentSnapshot> fetchMessageById(String id) async {
    return FirebaseFirestore.instance.collection('messages').doc(id).get();
  }

  Future<void> createNewChat() async {
    UserModel currentUser = UserRepository.getInstance().getUser()!;
    Map<String, dynamic> map = {
      'name': 'Chat ${currentUser.name}',
      'participantsIds': [currentUser.id],
      'participantsDetails': [currentUser.toMap()],
      'dateTimeCreated': DateTime.now(),
    };
    FirebaseFirestore.instance.collection('chats').add(map);
  }
}
