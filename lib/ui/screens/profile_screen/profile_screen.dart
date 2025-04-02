import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_chat/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:simple_chat/models/user.dart';
import 'package:simple_chat/ui/common_widgets/circle_avatar_container.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key, required this.currentUser}) : super(key: key);

  final UserModel currentUser;

  Route route() {
    return MaterialPageRoute<void>(
      builder: (_) => ProfileScreen(currentUser: currentUser),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        backgroundColor: Colors.black54,
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatarContainer(
                imageUrl: currentUser.imageUrl,
                containerSize: 128,
                defaultIconColor: Colors.black54,
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                currentUser.name,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: () async {
                  context.read<AuthenticationBloc>().add(AuthenticationLogoutRequested());
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(377, 94),
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  elevation: 0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.logout,
                      size: 48,
                      color: Colors.black54,
                    ),
                    const SizedBox(
                      width: 40,
                    ),
                    Text(
                      'Logout',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
