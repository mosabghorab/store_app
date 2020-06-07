//||... Class for all shared styles inside the app  ...||
import 'package:flutter/material.dart';

class AppStyles {
  //|. bold text style.|
  static const TextStyle boldTextStyle = const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.red,
  );

  //|. default  padding .|
  static const EdgeInsets defaultPadding1 = const EdgeInsets.all(8);
  static const EdgeInsets defaultPadding2 = const EdgeInsets.all(12);
  static const EdgeInsets defaultPadding3 = const EdgeInsets.all(16);
  static const EdgeInsets defaultPadding4 = const EdgeInsets.all(24);

  //|. default  border radius .|
  static const BorderRadius defaultBorderRadius = const BorderRadius.all(
    Radius.circular(16),
  );

  //|. default  underline border .|
  static const UnderlineInputBorder defaultUnderlineInputBorder =
      const UnderlineInputBorder(
    borderSide: BorderSide(color: Colors.black),
  );
}
