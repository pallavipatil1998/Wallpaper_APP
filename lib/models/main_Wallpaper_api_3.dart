import 'package:wallpaper_app/models/photos_model_2.dart';

class MainWallpaperApi{
  int? page;
  int? per_page;
  int? total_results;
  String? next_page ;
  List<PhotosModel>? photos;

  MainWallpaperApi(
      {this.page,
      this.per_page,
      this.total_results,
      this.next_page,
      this.photos});



  factory MainWallpaperApi.fromJson(Map<String,dynamic>json){
    List<PhotosModel> mPhoto=[];

    json['photos'].forEach((element) {
      mPhoto.add(PhotosModel.fromJson(element));
    });

    // 2 or use for loop
   // for(Map<String,dynamic> eachPhoto in json["photos"]){
   //   mPhoto.add(PhotosModel.fromJson(eachPhoto));
   // }

    return MainWallpaperApi(
      next_page:json["next_page"] ,
      page:json["page"]  ,
      per_page:json["per_page"]  ,
      photos:mPhoto,
      total_results:json["total_results"]  ,
    );
  }


}



