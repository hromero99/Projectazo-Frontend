import 'package:http/http.dart' as http;
import 'package:projectazo/models/designer.dart';
import '../util/url.dart';
import 'dart:convert';

class DesignerRepository{

  Future<Designer> get(int DesignerID) async{
    var request = await http.get(Url.designers + DesignerID.toString());
    if (request.statusCode == 200){
      var designer = Designer.fromJson(jsonDecode(request.body));
      return designer;
    }
    else{
      throw("Can't get information about user");
    }
  }

  Future<Designer> getFromUsername(String username) async{
    var request = await http.get(Url.designers + username);
    if (request.statusCode == 200){
      var designer = Designer.fromJson(jsonDecode(request.body));
      return designer;
    }
    else{
      throw("Can't get information about user");
    }
  }

}