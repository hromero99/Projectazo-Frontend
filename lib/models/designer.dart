import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:projectazo/util/url.dart';
class Designer{
  int id;
  String username;
  NetworkImage profilePicture;

  Map toJson(){
    return {
      '_id': this.id,
      'username': this.username,
      'profile_picture': this.profilePicture,
    };
  }
  factory Designer.fromJson(Map<String, dynamic> json){
    return Designer(
      id: json['id'],
      username: json['username'],
      profilePicture: NetworkImage(Url.baseUrl + json['profile_picture'])
    );
  }

  Designer({this.id, this.username, this.profilePicture});
}