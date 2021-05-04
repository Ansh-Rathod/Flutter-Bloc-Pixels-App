import 'package:flutter/material.dart';

class PixaList {
  final int id;
  final String pageURL;
  final String largeImageURL;
  final String user;
  final int userId;
  final int likes;
  final String previewURL;
  final String userImageURL;
  final String webformatURL;
  final String photographerurl;
  PixaList({
    @required this.webformatURL,
    @required this.id,
    @required this.pageURL,
    @required this.largeImageURL,
    @required this.user,
    @required this.userId,
    @required this.likes,
    @required this.previewURL,
    @required this.userImageURL,
    @required this.photographerurl,
  });
  factory PixaList.fromJson(Map<String, dynamic> json) {
    final username = json['photographer_url'];
    final splited = username.split('/')[3];
    return PixaList(
      id: json["id"],
      largeImageURL: json["src"]['large'],
      pageURL: json["url"],
      user: json["photographer"],
      userId: json["photographer_id"],
      likes: json["likes"],
      previewURL: json["src"]['medium'],
      userImageURL: splited,
      photographerurl: json['photographer_url'],
      webformatURL: json['src']['tiny'],
    );
  }
}

class PixaResponse {
  final List<PixaList> pixalist;
  PixaResponse({
    @required this.pixalist,
  });
  factory PixaResponse.fromJson(List<dynamic> json) {
    final pixalist = json.map((pic) => PixaList.fromJson(pic)).toList();
    return PixaResponse(pixalist: pixalist);
  }
}
