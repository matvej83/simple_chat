import 'package:flutter/material.dart';
import 'package:simple_chat/models/user.dart';
import 'package:simple_chat/theme/colors.dart';
import 'package:simple_chat/ui/common_widgets/circle_avatar_container.dart';
import 'package:simple_chat/ui/screens/chat_screen/actions/chat_actions.dart';
import 'package:simple_chat/ui/screens/profile_screen/profile_screen.dart';

import '../../../../my_app.dart';

class ChatHeader extends StatelessWidget with ChatActions {
  const ChatHeader({Key? key, required this.currentUser}) : super(key: key);

  final UserModel currentUser;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: greyVideoCallToolBarBackground,
          child: Padding(
            padding: const EdgeInsets.only(top: 40, left: 10, right: 10, bottom: 10),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                GestureDetector(
                  onTap: () {
                    navigator.push(
                      ProfileScreen(currentUser: currentUser).route(),
                    );
                  },
                  child: CircleAvatarContainer(
                    imageUrl: currentUser.imageUrl,
                    containerSize: 48,
                  ),
                ),
                const Spacer(),
                Text(
                  'Chat',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white),
                ),
                const Spacer(),
                RawMaterialButton(
                  onPressed: () async {
                    await createNewChat();
                  },
                  constraints: const BoxConstraints(minWidth: 24),
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 24.0,
                  ),
                  shape: const CircleBorder(
                    side: BorderSide(
                      width: 2,
                      color: Colors.white,
                      style: BorderStyle.solid,
                    ),
                  ),
                  elevation: 2.0,
                  fillColor: Colors.transparent,
                  padding: const EdgeInsets.all(8.0),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
