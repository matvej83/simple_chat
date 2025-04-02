import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_chat/providers/home_tab_bar_provider.dart';
import 'package:simple_chat/theme/colors.dart';

class BottomNavigationBarItems extends StatelessWidget {
  const BottomNavigationBarItems({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: (index) =>
          Provider.of<HomeTabBarPageProvider>(context, listen: false)
              .changeTab(index),
      currentIndex: context.watch<HomeTabBarPageProvider>().currentTabIndex,
      type: BottomNavigationBarType.fixed,
      iconSize: 20,
      backgroundColor: Colors.white,
      selectedItemColor: deepPurple,
      selectedFontSize: 12,
      unselectedItemColor: deepViolet.withOpacity(0.8),
      unselectedFontSize: 12,
      items: const [
        BottomNavigationBarItem(
          icon: Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              Icons.chat_outlined,
            ),
          ),
          label: 'Chat',
        ),
        BottomNavigationBarItem(
          icon: Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              Icons.notifications_none_outlined,
            ),
          ),
          label: 'Notifications',
        ),
        BottomNavigationBarItem(
          icon: Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.more_horiz),
          ),
          label: 'More',
        ),
      ],
    );
  }
}
