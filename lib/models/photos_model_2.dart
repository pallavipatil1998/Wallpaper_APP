import 'package:wallpaper_app/models/src_model_1.dart';

class PhotosModel{
  int? height;
  int? id ;
  int? photographer_id;
  int? width;
  String? alt;
  String? avg_color;
  String? photographer ;
  String? photographer_url;
  String? url;
  bool? liked;
  SrcModel? src;

  PhotosModel(
      {this.height,
      this.id,
      this.photographer_id,
      this.width,
      this.alt,
      this.avg_color,
      this.photographer,
      this.photographer_url,
      this.url,
      this.liked,
      this.src});
  
  
  factory PhotosModel.fromJson(Map<String,dynamic> json){
    return PhotosModel(
      height: json["height"],
      width: json["width"],
      alt: json["alt"],
      avg_color: json["avg_color"],
      id: json["id"],
      liked: json["liked"],
      photographer: json["photographer"],
      photographer_id: json["photographer_id"],
      photographer_url: json["photographer_url"],
      src:SrcModel.fromJson(json["src"]) ,
      url: json["url"],
    );
  }
  
  
}