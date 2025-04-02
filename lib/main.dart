import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_chat/my_app.dart';
import 'package:simple_chat/providers/chat_provider.dart';
import 'package:simple_chat/providers/home_tab_bar_provider.dart';
import 'package:simple_chat/repositories/authentication_repository.dart';
import 'package:simple_chat/repositories/user_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<HomeTabBarPageProvider>(
          create: (_) => HomeTabBarPageProvider(),
        ),
        ChangeNotifierProvider<ChatProvider>(
          create: (_) => ChatProvider(),
        ),
      ],
      child: MyApp(
        authenticationRepository: AuthenticationRepository(),
        userRepository: UserRepository.getInstance(),
      ),
    ),
  );
}
