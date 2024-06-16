import 'dart:io';

import 'package:flutter/foundation.dart';

class SelectedImagesModel with ChangeNotifier {
  List<File?> images = [null, null, null, null, null, null, null, null, null];
  int activeIndex = 0;

  addImage(int index, File image) {
    images[index - 1] = image;
    print('okkkkkkkkkkk');
    print(image);
    notifyListeners();
  }
}
