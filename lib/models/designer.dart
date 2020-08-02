import 'package:flutter/material.dart';

class Designer{
  int id;
  String username;
  AssetImage profilePicture;
  Map toJson(){
    return {
      '_id': this.id,
      'username': this.username,
    };
  }
}