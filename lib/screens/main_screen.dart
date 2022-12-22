import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:memorygame/services/client_service.dart';
import 'package:memorygame/services/models/card_model.dart';
import 'package:memorygame/utils/constants/string_constants.dart';
import 'package:memorygame/utils/size_utils.dart';
import 'package:memorygame/utils/widgets/circular_indicator.dart';
import 'package:confetti/confetti.dart';
import 'package:memorygame/utils/widgets/dialog_box_widget.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({
    Key? key,
  }) : super(key: key);
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late ThemeData themeData;
  late ConfettiController _confettiController;

  List<GlobalKey<FlipCardState>> cardStateKeys = [];
  List<bool> cardFlips = [];

  bool isPlaying = false;
  bool isLoading = false;
  bool flip = false;
  bool wait = false;

  int previousIndex = -1;
  int moves = 0;
  int time = 0;
  double? width;
  double? height;

  List<CardModel> gridViewTiles = [];
  List<CardModel> cardList = [];

  Timer? timer;
  final player = AudioPlayer();

  @override
  void initState() {
    super.initState();

    _confettiController =
        ConfettiController(duration: const Duration(seconds: 10));
    reStart();
  }

  Future<void> reStart() async {
    isLoading = true;

    cardList = await ClientService.instance.getDataPairs();

    gridViewTiles = cardList;
    await getData();

    isLoading = false;
  }

  Future<void> getData() async {
    for (var i = 0; i < cardList.length; i++) {
      cardStateKeys.add(GlobalKey<FlipCardState>());
      cardFlips.add(true);
    }

    startTimer();
    gridViewTiles.shuffle();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (mounted) {
        setState(() {
          time = time + 1;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    themeData = Theme.of(context);
    width = MediaQuery.of(context).size.width;

    height = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () async {
        return await showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => DialogContainer(
            themeData: themeData,
            moves: moves,
            time: time,
            confettiController: _confettiController,
            text: 'Canceled',
            icon: Icons.close_outlined,
            color: Colors.red,
            bCompleted: false,
          ),
        );
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'MEMORY',
            style: themeData.textTheme.headline6!.copyWith(color: Colors.white),
          ),
          actions: [
            InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) => DialogContainer(
                      themeData: themeData,
                      moves: moves,
                      time: time,
                      confettiController: _confettiController,
                      text: 'Canceled',
                      icon: Icons.close_outlined,
                      color: Colors.red,
                      bCompleted: false,
                    ),
                  );
                },
                child: const Icon(Icons.close, color: Colors.white))
          ],
        ),
        body: SafeArea(child: mainScreenBodyUI()),
      ),
    );
  }

  SingleChildScrollView mainScreenBodyUI() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: SizeUtils.get(5),
          ),
          Padding(
            padding: EdgeInsets.all(SizeUtils.get(4)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'MOVES : $moves',
                  style: themeData.textTheme.titleMedium,
                ),
                Text(
                  "TIME TAKEN : $time SEC",
                  style: themeData.textTheme.titleMedium,
                ),
              ],
            ),
          ),
          isLoading
              ? const CircularIndicator()
              : Padding(
                  padding: EdgeInsets.all(SizeUtils.get(4)),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: width! > 600 && height! < 700
                          ? 6
                          : width! > 600
                              ? 4
                              : 3,
                    ),
                    itemBuilder: (context, index) => flipCardUI(index),
                    itemCount: gridViewTiles.length,
                  ),
                ),
        ],
      ),
    );
  }

  FlipCard flipCardUI(int index) {
    return FlipCard(
      key: cardStateKeys[index],
      speed: 200,
      onFlip: () => onFlip(index),
      direction: FlipDirection.HORIZONTAL,
      flipOnTouch: !wait ? cardFlips[index] : false,
      front: Container(
        margin: const EdgeInsets.all(4.0),
        decoration: const BoxDecoration(
          color: Colors.amber,
          image: DecorationImage(
            image: AssetImage(StringConstants.questionImage),
            fit: BoxFit.fill,
          ),
        ),
      ),
      back: gridViewTiles[index].isSelected
          ? Container(
              color: Colors.white,
            )
          : Card(
              elevation: 10,
              child: Container(
                margin: const EdgeInsets.all(4.0),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(gridViewTiles[index].imageAssetPath),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
    );
  }

  Future<void> onFlip(int index) async {
    if (!wait) {
      if (!flip) {
        flip = true;

        player.play(
          AssetSource(StringConstants.selectAudio),
          volume: 1,
        );

        previousIndex = index;
      } else {
        flip = false;

        if (previousIndex != index) {
          if (gridViewTiles[previousIndex].imageAssetPath !=
              gridViewTiles[index].imageAssetPath) {
            player.play(
              AssetSource(StringConstants.selectAudio),
              volume: 1,
            );
            setState(() {
              wait = true;
            });

            await toggle(index);
          } else {
            cardFlips[previousIndex] = false;
            cardFlips[index] = false;

            player.play(
              AssetSource(StringConstants.wellDoneAudio),
              volume: 1,
            );
            gridViewTiles[previousIndex].isSelected = true;
            gridViewTiles[index].isSelected = true;
            if (cardFlips.every((t) => t == false)) {
              timer!.cancel();
              // player.play(
              //   AssetSource('firewols.mp3'),
              //   volume: 1,
              // );
              showResult();
            }
            setState(() {
              moves++;
            });
          }
        }
      }
    }
  }

  Future<void> toggle(int index) async {
    Future.delayed(const Duration(milliseconds: 1500), () {
      cardStateKeys[previousIndex].currentState!.toggleCard();

      previousIndex = index;

      cardStateKeys[previousIndex].currentState!.toggleCard();

      setState(() {
        wait = false;
        moves++;
      });
    });
  }

  void showResult() {
    if (isPlaying) {
      _confettiController.stop();
    } else {
      _confettiController.play();
    }
    isPlaying = !isPlaying;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => DialogContainer(
        themeData: themeData,
        moves: moves,
        time: time,
        confettiController: _confettiController,
        text: 'Won !!',
        icon: Icons.check_circle_outline,
        color: Colors.green,
        bCompleted: true,
      ),
    );
  }
}
