import 'dart:convert';
import 'dart:io';

import 'pixa_list.dart';
import 'package:http/http.dart' as http;

class PixaRepository {
  Future<PixaResponse> getPics() async {
    List data = [];
    for (int i = 1; i < 5; i++) {
      final response = await http.get(
        Uri.parse('https://api.pexels.com/v1/curated?per_page=80&page=${i}'),
        headers: {
          HttpHeaders.authorizationHeader:
              "get from pixels api,add your api key"
        },
      );
      var jsonBody = json.decode(response.body);
      data.addAll(jsonBody['photos']);
    }
    return PixaResponse.fromJson(data);
  }

  Future<PixaResponse> getSearchPic(String searchedText) async {
    String result = searchedText.replaceAll(RegExp(' +'), ' ');
    print(result);
    List data = [];
    for (int i = 1; i < 5; i++) {
      final response = await http.get(
        Uri.parse(
            'https://api.pexels.com/v1/search?query=$result&per_page=80&page=${i}'),
        headers: {
          HttpHeaders.authorizationHeader:
              ""
        },
      );
      var jsonBody = json.decode(response.body);
      data.addAll(jsonBody['photos']);
    }
    return PixaResponse.fromJson(data);
  }
}
