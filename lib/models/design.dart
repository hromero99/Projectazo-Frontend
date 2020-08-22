import '../models/designer.dart';
import '../networking/designer.dart';

class Design{
  //int id;
  //int Author;
  Designer author;
  String Description;
  String file;

  Map toJson(){
    return {
      'author': this.author,
      'description': this.Description,
      'file': this.file,
    };
  }
  factory Design.fromJson(Map<String, dynamic> json){
    return Design(
      author: json['author'],
      Description: json['description'],
      file: json['file'],
    );
  }
  Design({this.author, this.Description, this.file});
}