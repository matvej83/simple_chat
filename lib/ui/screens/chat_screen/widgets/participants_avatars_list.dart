import 'package:flutter/material.dart';
import 'package:simple_chat/theme/colors.dart';
import 'package:simple_chat/ui/common_widgets/circle_avatar_container.dart';

class ParticipantsAvatarsList extends StatelessWidget {
  const ParticipantsAvatarsList({Key? key, this.avatars = const []})
      : super(key: key);

  final List<String> avatars;

  Widget _buildAvatarsWidget({
    required List<dynamic> avatars,
    double size = 64,
  }) {
    final listWidget = <Widget>[];
    try {
      avatars.asMap().forEach((key, value) {
        if (listWidget.length < 3) {
          listWidget.add(
            Padding(
              padding: EdgeInsets.only(
                left: 36 * key.toDouble(),
              ),
              child: CircleAvatarContainer(
                imageUrl: value.toString(),
                containerSize: size,
                borderColor: backgroundLight,
                borderWidth: 2,
                defaultIconColor: Colors.black54,
              ),
            ),
          );
        }
      });
    } on Exception catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
    return Stack(
      textDirection: TextDirection.ltr,
      children: listWidget,
    );
  }

  @override
  Widget build(BuildContext context) {
    const double size = 64;
    return avatars.isNotEmpty
        ? SizedBox(
            height: size,
            child: _buildAvatarsWidget(avatars: avatars),
          )
        : const SizedBox(
            height: size,
            width: size,
          );
  }
}
