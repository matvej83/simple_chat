import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_chat/models/chat_model.dart';
import 'package:simple_chat/models/message_model.dart';
import 'package:simple_chat/providers/chat_provider.dart';
import 'package:simple_chat/theme/colors.dart';
import 'package:simple_chat/ui/screens/chat_screen/actions/chat_actions.dart';
import 'package:simple_chat/ui/screens/chat_screen/widgets/participants_avatars_list.dart';
import 'package:simple_chat/utils/date_time.dart';

class ChatItem extends StatefulWidget with ChatActions {
  const ChatItem({Key? key, required this.chat}) : super(key: key);
  final ChatModel chat;

  @override
  State<ChatItem> createState() => _ChatItemState();
}

class _ChatItemState extends State<ChatItem> {
  List<String> avatars = [];

  @override
  void initState() {
    super.initState();
    widget.chat.participantsDetails.forEach((element) {
      avatars.add(element.imageUrl);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              ParticipantsAvatarsList(
                avatars: avatars,
              ),
              if (avatars.length > 2)
                Chip(
                  label: Text('+${avatars.length - 2}'),
                  backgroundColor: lightGreen,
                ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.chat.name,
                    overflow: TextOverflow.ellipsis,
                  ),
                  FutureBuilder<DocumentSnapshot>(
                      future: widget
                          .fetchMessageById(widget.chat.lastMessageId ?? ''),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        String authorId = '';
                        String authorName = '';
                        String text = '';
                        if (snapshot.hasData) {
                          authorId = MessageModel.fromFirebase(
                                  snapshot: snapshot.data!)
                              .authorId;
                          authorName =
                              Provider.of<ChatProvider>(context, listen: false)
                                      .usersMap[authorId]
                                      ?.name ??
                                  '';
                          text = MessageModel.fromFirebase(
                                  snapshot: snapshot.data!)
                              .text;
                        }

                        return authorId.isNotEmpty
                            ? Text(
                                '$authorName: $text',
                                overflow: TextOverflow.ellipsis,
                              )
                            : Container();
                      }),
                ],
              ),
            ),
          ),
          const Spacer(),
          Text(
            getDateOrTime(datetime: widget.chat.lastMessaged),
            style: const TextStyle(color: deepViolet),
          ),
        ],
      ),
    );
  }
}
