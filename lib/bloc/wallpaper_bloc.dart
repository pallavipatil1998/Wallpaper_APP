import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallpaper_app/api/api_helper.dart';
import 'package:wallpaper_app/api/urls.dart';
import 'package:wallpaper_app/bloc/wallpaper_event.dart';
import 'package:wallpaper_app/bloc/wallpaper_state.dart';
import 'package:wallpaper_app/models/main_Wallpaper_api_3.dart';

class WallpaperBloc extends Bloc< WallpaperEvent,WallpaperState>{

  ApiHelper db;
  WallpaperBloc({required this.db}):super(WallpaperInitialState()){
    on<WallGetTrandingEvent>((event, emit)async {
      emit(WallpaperLoadingState());
     var res = await db.getApi(url: "${Urls.trandingWallUrl}");
     // var data= MainWallpaperApi.fromJson(res);
     // print("BODY DATA: ${data}");
     if(res !=null){
       emit(WallpaperLoadedState(wallModel: MainWallpaperApi.fromJson(res) ));

     }else{
       emit(WallpaperErrorState(errorMsg: "Internet Error"));
     }
    },);
  }
}