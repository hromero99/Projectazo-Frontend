
class Design{
  //int id;
  //Designer Author;
  int Author;
  String Description;
  String file;

  Map toJson(){
    return {
      'author': this.Author,
      'description': this.Description,
      'file': this.file,
    };
  }
  factory Design.fromJson(Map<String, dynamic> json){
    return Design(
      Author: json['author'],
      Description: json['description'],
      file: json['file'],
      );
  }
  Design({this.Author, this.Description, this.file});
}