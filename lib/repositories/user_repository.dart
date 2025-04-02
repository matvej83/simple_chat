import 'package:firebase_auth/firebase_auth.dart';
import 'package:simple_chat/models/user.dart';

class UserRepository {
  static final UserRepository _instance = UserRepository._internal();

  factory UserRepository() {
    return _instance;
  }

  UserRepository._internal();

  static UserRepository getInstance() {
    return _instance;
  }

  UserModel? _user;

  UserModel? getUser() {
    if (_user != null) return _user;
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      return null;
    } else {
      _user = UserModel(
          id: currentUser.uid,
          name: currentUser.displayName ?? '',
          email: currentUser.email ?? '');
      return _user;
    }
  }
}
