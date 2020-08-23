import 'package:http/http.dart' as http;
import 'package:projectazo/models/design.dart';
import 'package:projectazo/models/designer.dart';
import 'package:projectazo/networking/designer.dart';
import '../util/url.dart';
import 'dart:io';
import 'dart:convert';
import 'api.dart';

class DesignRepository{

  Future<int> createDesign(File image, Designer user, String description) async{
    var token = await  Api().storage.read(key: "token");
    var req = http.MultipartRequest('POST', Uri.parse(Url.designsUrl));
    print(Url.designsUrl);
    req.fields['author'] = user.id.toString();
    req.fields["description"] = description;
    req.headers.addAll({
      "Content-Type": "image/jpeg",
      "Authorization": "Token " + token,
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
        Iterable rawDesignslist = json.decode(request.body);
        //List<Design> designs =  rawDesignslist.map((model) => Design.fromJson(model)).toList();
        List <Design> designs = [];
        for (var rawDesign in rawDesignslist){
          Designer author = await DesignerRepository().get(rawDesign['author']);
          rawDesign['author'] = author;
          designs.add(Design.fromJson(rawDesign));
        }
        return designs;
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


  Future<List<Design>> getUserDesigns(String username) async{
    var request = await http.get(Url.designsUrl + username);
    print(Url.designsUrl + username);
    if (request.statusCode == 200) {
      Iterable rawDesignsList = json.decode(request.body);
      List <Design> designs = [];
      for (var rawDesign in rawDesignsList){
        Designer author = await DesignerRepository().get(rawDesign['author']);
        rawDesign['author'] = author;
        rawDesign['file'] = Url().getImageLink(rawDesign['file']);
        designs.add(Design.fromJson(rawDesign));
      }
      return designs;
    }
    else{
      throw(request.statusCode);
    }
  }
}
