import 'package:wallpaper_app/models/main_Wallpaper_api_3.dart';

abstract class WallSearchState{}

class WallSearchInitialState extends WallSearchState{}
class WallSearchLoadingState extends WallSearchState{}
class WallSearchLoadedState extends WallSearchState{
  MainWallpaperApi wallModel;
  WallSearchLoadedState({required this.wallModel});
}
class WallSearchErrorState extends WallSearchState{
  String? errorMsg;
  WallSearchErrorState({required this.errorMsg});
}

class WallSearchInterNetErrorState extends WallSearchState{
  String? errorMsg;
  WallSearchInterNetErrorState({required this.errorMsg});
}