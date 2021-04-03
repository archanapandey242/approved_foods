import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:approved_foods/foodDetailsBO.dart';
import 'package:http/http.dart' as http;

class ServiceManager {
  static HttpClient client;

  static Future<dynamic> get(String url) async {
    try {
      final response = await http.get(
          Uri.parse('https://api.jsonbin.io/b/5fce7e1e2946d2126fff85f0'),
          headers: {"Accept": "application/json"});
      List<FoodDetailsBO> list = List();
      list.add(FoodDetailsBO.fromJson(json.decode(response.body.toString())));
      return list;
    } catch (exception) {
      throw "Failed";
    }
  }
}
