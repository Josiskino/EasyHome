import 'dart:io';

import 'package:flutter/foundation.dart';

class SelectQuartier with ChangeNotifier {
  int _activeIndex = -1;
  String quartierChoice = '';

  int get activeIndex => _activeIndex;

  set activeIndex(int index) {
    _activeIndex = index;
    notifyListeners();
  }
}
