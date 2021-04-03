import 'dart:async';

import 'package:approved_foods/foodDetailsBO.dart';
import 'package:approved_foods/serviceManager.dart';

abstract class Bloc {
  void dispose();
}

class FoodDetailsBloc implements Bloc {
  final _foodListController = StreamController<List<FoodDetailsBO>>.broadcast();
  Stream<List<FoodDetailsBO>> get foodStream => _foodListController.stream;

  void fnGetFoodList() async {
    var data = await ServiceManager.get(
        "https://api.jsonbin.io/b/5fce7e1e2946d2126fff85f0");
    if (data != null) {
      _foodListController.sink.add(data);
    }
  }

  @override
  void dispose() {
    _foodListController.close();
  }
}
