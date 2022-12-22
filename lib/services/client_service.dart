import 'package:memorygame/services/models/card_model.dart';

class ClientService {
  ClientService._internal();
  static ClientService instance = ClientService._internal();

  Future<List<CardModel>> getDataPairs() async {
    List<CardModel> dataList = [
      CardModel(imageAssetPath: "assets/images/bird1.jpg", isSelected: false),
      CardModel(imageAssetPath: "assets/images/bird2.jpg", isSelected: false),
      CardModel(imageAssetPath: "assets/images/bird3.jpg", isSelected: false),
      CardModel(imageAssetPath: "assets/images/bird4.jpg", isSelected: false),
      CardModel(imageAssetPath: "assets/images/bird5.jpg", isSelected: false),
      CardModel(imageAssetPath: "assets/images/bird6.jpg", isSelected: false),
      CardModel(imageAssetPath: "assets/images/bird1.jpg", isSelected: false),
      CardModel(imageAssetPath: "assets/images/bird2.jpg", isSelected: false),
      CardModel(imageAssetPath: "assets/images/bird3.jpg", isSelected: false),
      CardModel(imageAssetPath: "assets/images/bird4.jpg", isSelected: false),
      CardModel(imageAssetPath: "assets/images/bird5.jpg", isSelected: false),
      CardModel(imageAssetPath: "assets/images/bird6.jpg", isSelected: false),
    ];

    return dataList;
  }
}
