import 'dart:math';

import 'package:flutter/cupertino.dart';

class FontSizes {
  static double h1(BuildContext context) {
    return MediaQuery.of(context).size.width / 8;
  }

  static double h2(BuildContext context) {
    return MediaQuery.of(context).size.width / 12;
  }

  static double h3(BuildContext context) {
    return MediaQuery.of(context).size.width / 18;
  }

  static double normal(BuildContext context) {
    return MediaQuery.of(context).size.width / 22;
  }

  static double description(BuildContext context) {
    return MediaQuery.of(context).size.width / 55;
  }

  static double biggerText(BuildContext context) {
    return MediaQuery.of(context).size.width / 16;
  }

  static double small(BuildContext context) {
    return MediaQuery.of(context).size.width / 28;
  }

  static double extraSmall(BuildContext context) {
    return MediaQuery.of(context).size.width / 40;
  }

  static double extraExtraSmall(BuildContext context) {
    return MediaQuery.of(context).size.width / 50;
  }

  static double extraExtraExtraSmall(BuildContext context) {
    return MediaQuery.of(context).size.width / 60;
  }

  static double flexibleEESmall(BuildContext context) {
    return sqrt(MediaQuery.of(context).size.width / 20) + 10;
  }

  static double flexibleNormal(BuildContext context) {
    return sqrt(MediaQuery.of(context).size.width / 15) + 15;
  }
}
