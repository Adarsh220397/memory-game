import 'package:flutter/material.dart';
import 'package:memorygame/screens/main_screen.dart';
import 'package:memorygame/utils/constants/color_constants.dart';
import 'package:memorygame/utils/size_utils.dart';
import 'package:memorygame/utils/widgets/circular_indicator.dart';
import 'package:memorygame/utils/widgets/icon_widget.dart';

class HomeScreen extends StatefulWidget {
  bool bCompleted;
  int moves;
  HomeScreen({super.key, required this.bCompleted, required this.moves});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ThemeData themeData;

  bool isLoading = false;

  int levelNumber = 1;
  int numberOfCards = 12;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    themeData = Theme.of(context);
    return isLoading
        ? const CircularIndicator()
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.black,
              title: Text(
                'MEMORY GAME',
                style: themeData.textTheme.headline6!
                    .copyWith(color: Colors.white),
              ),
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                child: SizedBox(
                  height: height,
                  width: width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      cardUI(),
                    ],
                  ),
                ),
              ),
            ),
          );
  }

  Widget cardUI() {
    return Flexible(
      flex: 1,
      child: InkWell(
        onTap: () {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const MainScreen()),
              (Route<dynamic> route) => false);
        },
        child: Container(
          padding: const EdgeInsets.all(8),
          height: SizeUtils.get(25),
          width: MediaQuery.of(context).size.width,
          child: Card(
            elevation: 10,
            color: widget.bCompleted ? Colors.greenAccent : null,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      ' $levelNumber. ',
                      style: themeData.textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    Text(
                      ' $numberOfCards CARDS',
                      style: themeData.textTheme.headline6!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                iconRow()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row iconRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconWidget(
          iconData: Icons.military_tech_outlined,
          color: widget.moves > 0 && widget.bCompleted
              ? Colors.brown
              : ColorConstants.medalColor,
          size: SizeUtils.get(12),
        ),
        IconWidget(
          iconData: Icons.military_tech_outlined,
          color: widget.moves < 15 && widget.moves > 0 && widget.bCompleted
              ? Colors.grey
              : ColorConstants.medalColor,
          size: SizeUtils.get(12),
        ),
        IconWidget(
          iconData: Icons.military_tech_outlined,
          color: widget.moves < 10 && widget.moves > 0 && widget.bCompleted
              ? Colors.amber
              : ColorConstants.medalColor,
          size: SizeUtils.get(12),
        ),
        SizedBox(
          width: SizeUtils.get(2),
        ),
        widget.bCompleted
            ? IconWidget(
                iconData: Icons.check,
                color: Colors.green,
                size: SizeUtils.get(12),
              )
            : IconWidget(
                iconData: Icons.play_circle,
                size: SizeUtils.get(12),
              )
      ],
    );
  }
}
