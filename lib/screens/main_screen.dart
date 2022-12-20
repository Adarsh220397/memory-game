import 'dart:async';

import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:memorygame/screens/home_screen.dart';
import 'package:memorygame/services/client_service.dart';
import 'package:memorygame/services/models/card_model.dart';

int level = 8;

class Home extends StatefulWidget {
  // final int size;

  const Home({
    Key? key,
  }) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<GlobalKey<FlipCardState>> cardStateKeys = [];
  List<bool> cardFlips = [];
  bool isLoading = false;
  int previousIndex = -1;
  int nextIndex = 1;
  bool flip = false;
  // bool bSame = false;
  int time = 0;
  Timer? timer;
  int _time = 5;
  int? _left;
  bool _start = false;
  bool? _isFinished;
  List<CardModel> gridViewTiles = [];
  List<CardModel> questionPairs = [];
  List<CardModel> myPairs = [];
  bool _wait = false;
  List<int> tempArray = [];
  @override
  void initState() {
    super.initState();
    reStart();
  }

  getData() async {
    for (var i = 0; i < myPairs.length; i++) {
      cardStateKeys.add(GlobalKey<FlipCardState>());
      cardFlips.add(true);
    }

    // data.shuffle();

    gridViewTiles.shuffle();
  }

  startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (t) {
      setState(() {
        time = time - 1;
      });
    });
  }

  void reStart() async {
    isLoading = true;

    startTimer();
    myPairs = await ClientService.instance.getPairs();
    //  myPairs.shuffle();
    //  cardStateKeys = await ClientService.instance.getCardStateKeys();
    gridViewTiles = myPairs;
    await getData();
    _time = 5;
    _left = (gridViewTiles.length ~/ 2);
    _isFinished = false;
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        //  getQuaestionPairs();
        //selected = false;
        _start = true;
        timer!.cancel();
      });
    });
    isLoading = false;
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget getItem(int index) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey[100],
          boxShadow: [
            BoxShadow(
              color: Colors.black45,
              blurRadius: 3,
              spreadRadius: 0.8,
              offset: Offset(2.0, 1),
            )
          ],
          borderRadius: BorderRadius.circular(5)),
      margin: EdgeInsets.all(4.0),
      child: Image.asset(gridViewTiles[index].imageAssetPath),
    );
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? CircularProgressIndicator()
        : _isFinished!
            ? Scaffold(
                body: Center(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        reStart();
                      });
                    },
                    child: Container(
                      height: 50,
                      width: 200,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Text(
                        "Replay",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
              )
            : Scaffold(
                body: SafeArea(
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: _time > 0
                              ? Text(
                                  '$_time',
                                  style: Theme.of(context).textTheme.headline3,
                                )
                              : Text(
                                  'Left:$_left',
                                  style: Theme.of(context).textTheme.headline3,
                                ),
                        ),
                        Theme(
                          data: ThemeData.dark(),
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: GridView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                              ),
                              itemBuilder: (context, index) => FlipCard(
                                key: cardStateKeys[index],
                                onFlip: () => onFlip(index),
                                direction: FlipDirection.HORIZONTAL,
                                flipOnTouch: _wait ? false : cardFlips[index],
                                front: Container(
                                  margin: EdgeInsets.all(4.0),
                                  color: Colors.deepOrange.withOpacity(0.3),
                                ),
                                back: gridViewTiles[index].isSelected
                                    ? Container(
                                        color: Colors.white,
                                      )
                                    : Container(
                                        margin: EdgeInsets.all(4.0),
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(
                                                gridViewTiles[index]
                                                    .imageAssetPath),
                                            fit: BoxFit.fill,
                                          ),
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                              ),
                              // : getItem(index),
                              itemCount: gridViewTiles.length,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
  }

  // bool isExist(int index) {

  //   print('----$exist--------');
  //   return exist;
  // }

  onFlip(int index) {
    // if (tempArray
    //     .any((el) => el == index)) {
    //   return;
    // }

    // if (tempArray.length < 2) {
    //   tempArray.add(index);
    //   print(tempArray);
    //   print('-------------------');
    // } else {
    //   for (int i in tempArray) {
    //     Future.delayed(const Duration(milliseconds: 150), () {
    //       cardStateKeys[i].currentState!.toggleCard();
    //       // cardStateKeys[tempArray[1]].currentState!.toggleCard();
    //     });
    //     // gridViewTiles[tempArray[0]].isSelected = false;
    //     // gridViewTiles[tempArray[1]].isSelected = false;

    //     tempArray.clear();
    //     tempArray.add(index);
    //     print(tempArray);
    //   }
    //   // bool exist = tempArray.any((el) => el == index);
    //   // if (exist) print(tempArray);
    //   if (tempArray.length == 2) {
    //     ("lenght 2.....");

    //     // this.tempList[0] = 0

    //     // this.tempList[1] = 1

    //     if (gridViewTiles[tempArray[0]].imageAssetPath ==
    //         gridViewTiles[tempArray[1]].imageAssetPath) {
    //       print("isMatched");

    //       gridViewTiles[tempArray[0]].isSelected = true;
    //       print(gridViewTiles[index].isSelected);
    //       print(gridViewTiles[tempArray[0]].imageAssetPath);
    //       print(gridViewTiles[tempArray[0]].isSelected);

    //       gridViewTiles[tempArray[1]].isSelected = true;

    //       print(gridViewTiles[tempArray[1]].isSelected);
    //     }
    //   }
    //   setState(() {});
    if (!flip) {
      // if (tempArray.isEmpty) {
      flip = true;

      print('-flip-true--------');

      previousIndex = index;

      // tempArray.add(index);

      // for (int i in tempArray) {
      //   print(i);
      // }
      // cardStateKeys[tempArray[0]]
      //     .currentState!
      //     .toggleCard();
    } else {
      print('-flip-false--------');
      //  tempArray.add(index);
      // for (int i in tempArray) {
      //   print(i);
      // }
      // if (tempArray.length > 2) {
      //   print('------------');
      //   // cardStateKeys[tempArray[0]]
      //   //     .currentState!
      //   //     .toggleCard();
      //   // cardStateKeys[tempArray[1]]
      //   //     .currentState!
      //   //     .toggleCard();

      //   tempArray.removeRange(0, 2);
      // }
      flip = false;
      if (previousIndex != index) {
        if (gridViewTiles[previousIndex].imageAssetPath !=
            gridViewTiles[index].imageAssetPath) {
          _wait = true;

          Future.delayed(const Duration(milliseconds: 1500), () {
            print('----------');
            cardStateKeys[previousIndex].currentState!.toggleCard();

            previousIndex = index;

            cardStateKeys[previousIndex].currentState!.toggleCard();

            Future.delayed(const Duration(milliseconds: 160), () {
              setState(() {
                print('------');
                _wait = false;
              });
            });
          });
          // previousIndex = index;
        } else {
          cardFlips[previousIndex] = false;
          cardFlips[index] = false;
          print(cardFlips);
          //
          //bSame = true;

          gridViewTiles[previousIndex].isSelected = true;
          gridViewTiles[index].isSelected = true;

          if (cardFlips.every((t) => t == false)) {
            print("Won");
            showResult();
          }
          setState(() {});
        }
      }
    }
  }

  showResult() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text("Won!!!"),
        content: Text(
          "Time $time",
          //  style: Theme.of(context).textTheme.display2,
        ),
        actions: <Widget>[
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => HomeScreen(
                      //   size: level,
                      ),
                ),
              );
            },
            child: Text("HOME"),
          ),
        ],
      ),
    );
  }
}
