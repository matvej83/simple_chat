import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_chat/models/user.dart';
import 'package:simple_chat/providers/chat_provider.dart';
import 'package:simple_chat/repositories/user_repository.dart';
import 'package:simple_chat/ui/screens/chat_screen/widgets/chat_header.dart';
import 'package:simple_chat/ui/screens/chat_screen/widgets/chat_item.dart';
import 'package:simple_chat/ui/screens/chat_screen/widgets/custom_search_bar.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late UserModel currentUser = UserRepository.getInstance().getUser()!;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ChatHeader(
          currentUser: currentUser,
        ),
        const CustomSearchBar(),
        Consumer<ChatProvider>(builder: (context, chatProvider, child) {
          if (chatProvider.chats.isEmpty) {
            return const Text('No chats available!');
          }
          return Expanded(
            child: ListView.builder(
              itemCount: chatProvider.selectedChats.length,
              itemBuilder: (context, index) => ChatItem(
                chat: chatProvider.selectedChats[index],
              ),
            ),
          );
        })
      ],
    );
  }
}
