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
              "563492ad6f917000010000019051457aa9424d0db0e0b17147886a9e"
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
              "563492ad6f917000010000012bfc12dc463848e1b15a7cbb8ed27b64"
        },
      );
      var jsonBody = json.decode(response.body);
      data.addAll(jsonBody['photos']);
    }
    return PixaResponse.fromJson(data);
  }
}
