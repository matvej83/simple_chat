import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:simple_chat/models/user.dart';
import 'package:simple_chat/providers/chat_provider.dart';
import 'package:simple_chat/repositories/authentication_repository.dart';
import 'package:simple_chat/repositories/user_repository.dart';
import 'package:simple_chat/splash_page.dart';
import 'package:simple_chat/ui/screens/home_screen/home_screen.dart';
import 'package:simple_chat/ui/screens/login_screen/login_screen.dart';
import 'bloc/authentication_bloc/authentication_bloc.dart';
import 'models/chat_model.dart';

final _navigatorKey = GlobalKey<NavigatorState>();

NavigatorState get navigator => _navigatorKey.currentState!;

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.authenticationRepository, required this.userRepository});

  final AuthenticationRepository authenticationRepository;
  final UserRepository userRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: authenticationRepository,
      child: BlocProvider(
        create: (_) => AuthenticationBloc(
          authenticationRepository: authenticationRepository,
          userRepository: userRepository,
        ),
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatefulWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  _AppViewState createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  @override
  void initState() {
    super.initState();
    context.read<AuthenticationBloc>().add(AuthenticationLoginRequested());
    FirebaseFirestore.instance.collection('chats').snapshots().listen((docs) {
      final List<ChatModel> chats = [];
      docs.docs.forEach((element) {
        final ChatModel chat = ChatModel.fromFirebase(snapshot: element);
        chats.add(chat);
      });
      Provider.of<ChatProvider>(context, listen: false).setChatsList(chats: chats);
    });
    FirebaseFirestore.instance.collection('users').snapshots().listen((docs) {
      final List<UserModel> users = [];
      docs.docs.forEach((element) {
        final UserModel user = UserModel.fromFirebase(doc: element);
        users.add(user);
      });
      Provider.of<ChatProvider>(context, listen: false).setUsersList(users: users);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigatorKey,
      builder: (context, child) {
        return BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            switch (state.status) {
              case AuthenticationStatus.authenticated:
                navigator.pushAndRemoveUntil<void>(
                  HomeScreen.route(),
                  (route) => false,
                );
                break;
              case AuthenticationStatus.unauthenticated:
                navigator.pushAndRemoveUntil<void>(
                  LoginScreen.route(),
                  (route) => false,
                );
                break;
              default:
                break;
            }
          },
          child: child,
        );
      },
      onGenerateRoute: (_) => SplashPage.route(),
    );
  }
}
