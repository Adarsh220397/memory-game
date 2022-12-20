import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:memorygame/services/models/card_model.dart';

class ClientService {
  //Singleton instance
  ClientService._internal();
  static ClientService instance = ClientService._internal();

  Future<List<CardModel>> getPairs() async {
    List<CardModel> pairs = [
      CardModel(imageAssetPath: "assets/bird1.jpg", isSelected: false),
      CardModel(imageAssetPath: "assets/bird2.jpg", isSelected: false),
      CardModel(imageAssetPath: "assets/bird3.jpg", isSelected: false),
      CardModel(imageAssetPath: "assets/bird4.jpg", isSelected: false),
      CardModel(imageAssetPath: "assets/bird5.jpg", isSelected: false),
      CardModel(imageAssetPath: "assets/bird6.jpg", isSelected: false),
      CardModel(imageAssetPath: "assets/bird1.jpg", isSelected: false),
      CardModel(imageAssetPath: "assets/bird2.jpg", isSelected: false),
      CardModel(imageAssetPath: "assets/bird3.jpg", isSelected: false),
      CardModel(imageAssetPath: "assets/bird4.jpg", isSelected: false),
      CardModel(imageAssetPath: "assets/bird5.jpg", isSelected: false),
      CardModel(imageAssetPath: "assets/bird6.jpg", isSelected: false),
    ];

    return pairs;
  }

  Future<List<CardModel>> getQuestionPairs() async {
    List<CardModel> pairs = [
      CardModel(imageAssetPath: "assets/question.png", isSelected: false),
      CardModel(imageAssetPath: "assets/question.png", isSelected: false),
      CardModel(imageAssetPath: "assets/question.png", isSelected: false),
      CardModel(imageAssetPath: "assets/question.png", isSelected: false),
      CardModel(imageAssetPath: "assets/question.png", isSelected: false),
      CardModel(imageAssetPath: "assets/question.png", isSelected: false),
      CardModel(imageAssetPath: "assets/question.png", isSelected: false),
      CardModel(imageAssetPath: "assets/question.png", isSelected: false),
      CardModel(imageAssetPath: "assets/question.png", isSelected: false),
      CardModel(imageAssetPath: "assets/question.png", isSelected: false),
      CardModel(imageAssetPath: "assets/question.png", isSelected: false),
      CardModel(imageAssetPath: "assets/question.png", isSelected: false),
    ];

    return pairs;
  }

  Future<List<GlobalKey<FlipCardState>>> getCardStateKeys() async {
    List<GlobalKey<FlipCardState>> cardStateKeys = [];

    for (int i = 0; i < 13; i++) {
      cardStateKeys.add(GlobalKey<FlipCardState>());
    }

    return cardStateKeys;
  }
}
