import 'package:flutter/foundation.dart';

class HomeTabBarPageProvider with ChangeNotifier {
  int _index = 0;
  int get currentTabIndex => _index;
  bool isCompleteFirstStart = true;

  void changeTab(int index) {
    _index = index;
    notifyListeners();
  }
}
