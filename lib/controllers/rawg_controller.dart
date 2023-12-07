import 'dart:convert';

import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/state_manager.dart';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:neurogine_app/models/game_model.dart';

import '../env/env.dart';

class RawgController extends GetxController {
  var isLoading = false.obs;
  var pageCount = 1.obs;

  GameModel? gameModel;

  dynamic result;

  @override
  Future<void> onInit() async {
    super.onInit();
    fetchGames(pageCount);
  }

  fetchGames(pageCount) async {
    try {
      // Set isLoading to true shows that fetching is started
      isLoading(true);

      // Set start date with 1 year from current date
      // Set end date with current date
      var now = DateTime.now();
      var currDate = DateFormat("yyyy-MM-dd").format(now);
      var lastYear = now.subtract(Duration(days: 365));
      var startDate = DateFormat("yyyy-MM-dd").format(lastYear);

      // Get Api key
      var apiKey = Env.apiKey;

      // Set url
      var url = Uri.tryParse(
          "https://api.rawg.io/api/games?page=$pageCount&page_size=20&platforms=187&dates=$startDate,$currDate&ordering=-released&key=$apiKey");

      // Get data
      var response = await http.get(url!);

      print("status code=${response.statusCode}");

      // Get successfully 200 OK
      if (response.statusCode == 200) {
        // Decode json body
        var result = jsonDecode(response.body);

        // Remap with Game Model
        gameModel = GameModel.fromJson(result);
      } else {
        print('$url-error fetching');
      }
    } catch (err) {
      print("Error fetch game - $err");
    } finally {
      // Turn loading off
      isLoading(false);
    }
  }

  fetchDetailGame(id) async {
    isLoading(true);

    try {
      // Get api key
      var apiKey = Env.apiKey;

      // Set url
      var url = Uri.tryParse("https://api.rawg.io/api/games/$id?key=$apiKey");

      // Get data
      var response = await http.get(url!);

      print("status code=${response.statusCode}");

      // Get successfully 200 OK
      if (response.statusCode == 200) {
        // Decode json body
        result = jsonDecode(response.body);
      } else {
        print('$url-error detail fetching');
      }
    } catch (err) {
      print("Error fetch detail game - $err");
    } finally {
      // Turn loading off
      isLoading(false);
    }
  }

  // Add page count increment 1
  addPageCount() => pageCount.value++;

  // Minus page count decrement 1
  removePageCount() {
    if (pageCount.value > 1) {
      pageCount.value--;
    }
  }
}
