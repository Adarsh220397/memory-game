import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:memorygame/screens/home_screen.dart';
import 'package:memorygame/utils/constants/color_constants.dart';
import 'package:memorygame/utils/size_utils.dart';
import 'package:memorygame/utils/widgets/icon_widget.dart';

class DialogContainer extends StatefulWidget {
  const DialogContainer({
    Key? key,
    required this.themeData,
    required this.text,
    required this.moves,
    required this.time,
    required this.icon,
    required this.color,
    required this.bCompleted,
    required ConfettiController confettiController,
  })  : _confettiController = confettiController,
        super(key: key);
  final IconData icon;
  final ThemeData themeData;
  final int moves;
  final int time;
  final ConfettiController _confettiController;
  final String text;
  final Color color;
  final bool bCompleted;

  @override
  State<DialogContainer> createState() => _DialogContainerState();
}

class _DialogContainerState extends State<DialogContainer> {
  late ThemeData themeData;
  @override
  Widget build(BuildContext context) {
    themeData = Theme.of(context);

    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(SizeUtils.get(2)),
      child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                width: SizeUtils.get(60),
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        spreadRadius: 10,
                        blurRadius: 2,
                      ),
                    ],
                    border: Border.all(color: Colors.black)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      widget.text,
                      textAlign: TextAlign.center,
                      style: widget.themeData.textTheme.headline5!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: SizeUtils.get(2),
                    ),
                    Align(
                      child: Icon(
                        widget.icon,
                        size: SizeUtils.get(12),
                        color: widget.color,
                      ),
                    ),
                    Text(
                      "MOVES : ${widget.moves} ",
                      style: widget.themeData.textTheme.titleMedium!
                          .copyWith(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: SizeUtils.get(1),
                    ),
                    Text(
                      "Time Taken : ${widget.time} seconds",
                      style: widget.themeData.textTheme.titleMedium!
                          .copyWith(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: SizeUtils.get(1),
                    ),
                    widget.bCompleted ? iconRow() : const SizedBox(),
                    SizedBox(
                      height: SizeUtils.get(1),
                    ),
                    buttonRow(context),
                    SizedBox(
                      height: SizeUtils.get(2),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: ConfettiWidget(
                        confettiController: widget._confettiController,
                        blastDirection: -pi / 2,
                      ),
                    ),
                  ],
                )),
          ]),
    );
  }

  Row buttonRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => HomeScreen(
                    bCompleted: widget.bCompleted,
                    moves: widget.moves,
                  ),
                ),
                (Route<dynamic> route) => false);
          },
          child: Row(
            children: [
              Text(
                "HOME",
                style: themeData.textTheme.subtitle1!
                    .copyWith(color: Colors.white),
              ),
              IconWidget(iconData: Icons.play_arrow)
            ],
          ),
        ),
      ],
    );
  }

  Row iconRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconWidget(
          iconData: Icons.military_tech_outlined,
          color: Colors.brown,
          size: SizeUtils.get(12),
        ),
        IconWidget(
          iconData: Icons.military_tech_outlined,
          color: widget.moves < 15 ? Colors.grey : ColorConstants.medalColor,
          size: SizeUtils.get(12),
        ),
        IconWidget(
          iconData: Icons.military_tech_outlined,
          color: widget.moves < 10 ? Colors.amber : ColorConstants.medalColor,
          size: SizeUtils.get(12),
        ),
      ],
    );
  }
}
