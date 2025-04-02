import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_chat/providers/home_tab_bar_provider.dart';
import 'package:simple_chat/ui/screens/bottom_navigation_bar/bottom_navigation_bar_items.dart';
import 'package:simple_chat/ui/screens/chat_screen/chat_screen.dart';
import 'package:simple_chat/ui/screens/notifications_screen/notifications_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const HomeScreen());
  }

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Widget _getPage() {
    switch (context.watch<HomeTabBarPageProvider>().currentTabIndex) {
      case 0:
        return const ChatScreen();
      case 1:
        return const NotificationsScreen();
      case 2:
        return const Center(
          child: Text('More'),
        );
      default:
        return Container(color: Colors.white);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: _getPage()),
      bottomNavigationBar:
          const BottomNavigationBarItems(), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
