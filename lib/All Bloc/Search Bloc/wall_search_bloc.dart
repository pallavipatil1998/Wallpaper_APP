import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallpaper_app/All%20Bloc/Search%20Bloc/wall_search_event.dart';
import 'package:wallpaper_app/All%20Bloc/Search%20Bloc/wall_search_state.dart';
import 'package:wallpaper_app/api/my_exception.dart';
import 'package:wallpaper_app/api/urls.dart';
import 'package:wallpaper_app/models/main_Wallpaper_api_3.dart';

import '../../api/api_helper.dart';

class WallSearchBloc extends Bloc<WallSearchEvent,WallSearchState>{
  ApiHelper db;
  WallSearchBloc({required this.db}):super(WallSearchInitialState()){
    on<GetSerachWallEvent>((event, emit)async {
      emit(WallSearchLoadingState());
     try{
       var res= await db.getApi(url:"${Urls.searchingWallUrls}?query=${event.query}&color=${event.mColor}&per_page=70 ");
       emit(WallSearchLoadedState(wallModel: MainWallpaperApi.fromJson(res)));
     } catch(e){
       if(e is FetchDataException){
         emit(WallSearchInterNetErrorState(errorMsg: e.toString()));
       }else{
         emit(WallSearchErrorState( errorMsg: e.toString()));
       }
     }

    },);
  }

}