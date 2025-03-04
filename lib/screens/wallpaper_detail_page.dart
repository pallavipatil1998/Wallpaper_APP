
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:wallpaper/wallpaper.dart';

class WallpaperDetailPage extends StatelessWidget {
  String imgUrl;
  double? mWidth;
  double? mHeight;
   WallpaperDetailPage({required this.imgUrl});

  @override
  Widget build(BuildContext context) {
    mWidth=MediaQuery.of(context).size.width;
    mHeight=MediaQuery.of(context).size.height;
    return Scaffold(
      body:Stack(
        children: [
          Container(
            width: double.infinity,
             height: double.infinity,
           decoration: BoxDecoration(
             image: DecorationImage(image: NetworkImage(imgUrl),fit: BoxFit.fitHeight)
           ),
          ),

          Positioned(
            top: 70,left: 34,
              child:InkWell(
                onTap: (){
                  Navigator.pop(context);
                },
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.white, shape: BoxShape.circle),
                    child: Icon(Icons.arrow_back_ios_new),
                  )
              )
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(21.0),
              child: Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: (){
                      downloadWallpaper();

                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.white, shape: BoxShape.circle),
                      child: Icon(Icons.download),
                    ),
                  ),
                  SizedBox(width: 21,),
                  InkWell(
                    onTap: (){
                      setWallpaper();

                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.white, shape: BoxShape.circle),
                      child: Icon(Icons.wallpaper,
                    ),
                  ),),
              ],),
            ),
          ),

        ],
      ) ,
    );
  }


  setWallpaper(){
    var downloadStreme=Wallpaper.imageDownloadProgress(imgUrl);
    downloadStreme.listen((event){
      print(event.toString());
    },onDone:()async{
      print("Wallpaper downloaded in app cache..");
      var check=await Wallpaper.homeScreen(
        width: mWidth!,
        height: mHeight!,
        options: RequestSizeOptions.resizeExact
      );
      print("Wallpaper: $check");
    },onError: (e){
      print("Error: $e");
    }

    );

  }


  downloadWallpaper()async{
    GallerySaver.saveImage(imgUrl).then((value){
      print(value);
    });

  }





}
