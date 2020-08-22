import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:projectazo/networking/designer.dart';
import '../models/designer.dart';
import '../util/url.dart';

class Api{
  final storage = new FlutterSecureStorage();

  Future<Designer> login(String username, String password) async{
    var body  = {
      "username": username,
      "password": password
    };
    var request = await http.post(
      Url.loginUrl,
      body: body,
    );
    if (request.statusCode == 200){
      await storage.write(key: "token", value:jsonDecode(request.body)['token'] );
      var designer = await DesignerRepository().getFromUsername(body['username']);
      return designer;
    }
  }
}