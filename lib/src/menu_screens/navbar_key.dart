import 'package:flutter/material.dart';

class Navbarkey {
  Navbarkey._();
  static final GlobalKey _key = GlobalKey();
  static GlobalKey getKey() => _key;
}
