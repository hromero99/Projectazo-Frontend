
class Url{
  //Base Url
  static const baseUrl = "http://192.168.43.20:8000";
  static const designsUrl = "$baseUrl/design/";
  static const loginUrl = "$baseUrl/login/";
  static const designers = "$baseUrl/designers/";

  String getImageLink(String originalLink){
    return baseUrl + originalLink;
  }
}