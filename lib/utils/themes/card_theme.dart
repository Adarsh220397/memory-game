import 'package:flutter/material.dart';
import 'package:memorygame/utils/constants/color_constants.dart';

cardTheme() {
  return const CardTheme(
      margin: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
      elevation: 10,
      color: ColorConstants.cardColor,
      shape: Border(bottom: BorderSide(color: Colors.white54, width: 2)));
}
