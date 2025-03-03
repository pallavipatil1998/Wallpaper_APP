import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallpaper_app/api/api_helper.dart';
import 'package:wallpaper_app/api/my_exception.dart';
import 'package:wallpaper_app/api/urls.dart';
import 'package:wallpaper_app/bloc/wallpaper_event.dart';
import 'package:wallpaper_app/bloc/wallpaper_state.dart';
import 'package:wallpaper_app/models/main_Wallpaper_api_3.dart';

class WallpaperBloc extends Bloc< WallpaperEvent,WallpaperState>{

  ApiHelper db;
  WallpaperBloc({required this.db}):super(WallpaperInitialState()){
    on<WallGetTrandingEvent>((event, emit)async {
      emit(WallpaperLoadingState());
    try{
      var res = await db.getApi(url: "${Urls.trandingWallUrl}");
      emit(WallpaperLoadedState(wallModel: MainWallpaperApi.fromJson(res)));

    }catch(e){
      if(e is FetchDataException){
        emit(WallpaperInterNetErrorState(errorMsg: e.toString()));
      }else{
        emit(WallpaperErrorState(errorMsg: e.toString()));
      }
    }
    },);


    on<WallGetSerachEvent>((event, emit)async {
      emit(WallpaperLoadingState());
      try{
        var res = await db.getApi(url: "${Urls.searchingWallUrls}");
        emit(WallpaperLoadedState(wallModel: MainWallpaperApi.fromJson(res)));

      }catch(e){
        if(e is FetchDataException){
          emit(WallpaperInterNetErrorState(errorMsg: e.toString()));
        }else{
          emit(WallpaperErrorState(errorMsg: e.toString()));
        }
      }
    },);




  }
}