import 'package:flutter/material.dart';
import 'package:memorygame/screens/home_screen.dart';
import 'package:memorygame/utils/constants/color_constants.dart';
import 'package:memorygame/utils/size_utils.dart';
import 'package:memorygame/utils/themes/card_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return OrientationBuilder(builder: (context, orientation) {
        SizeUtils.init(constraints, orientation);
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Memory Game',
          theme: ThemeData(
              primarySwatch: Colors.blue,
              cardTheme: cardTheme(),
              appBarTheme: const AppBarTheme(color: ColorConstants.appColor)),
          home: HomeScreen(bCompleted: false, moves: 0),
        );
      });
    });
  }
}
