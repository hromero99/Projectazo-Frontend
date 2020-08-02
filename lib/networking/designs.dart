import 'package:http/http.dart' as http;
import 'package:projectazo/models/design.dart';
import '../util/url.dart';
import 'dart:io';
import 'dart:convert';

class DesignRepository{

  Future<int> createDesign(File image) async{
    var req = http.MultipartRequest('POST', Uri.parse(Url.designsUrl));
    print(Url.designsUrl);
    req.headers.addAll({
      "Content-Type": "image/jpeg",
    });
    req.files.add(
        http.MultipartFile(
            'file',
            image.readAsBytes().asStream(),
            image.lengthSync(),
            filename: image.path
                .split("/")
                .last
        )
    );
    var response = await req.send();
    return response.statusCode;
  }

  Future<List<Design>> getDesignList() async{
      var request = await http.get(Url.designsUrl);

      if ( request.statusCode == 200 ) {
        Iterable list = json.decode(request.body);
        return list.map((model) => Design.fromJson(model)).toList();
      }
      else{
        throw Exception("Failed to load design");
      }
  }

  Future<Design> getDesign(int designId) async{
    var request = await http.get(Url.designsUrl + "/" +designId.toString() + "/");
    if (request.statusCode == 200){
      var design = Design.fromJson(jsonDecode(request.body));
      return design;
    }
    else{
      throw("Error getting design data");
    }
  }
}
