import 'package:wallpaper_app/models/main_Wallpaper_api_3.dart';

abstract class WallpaperState{}

class WallpaperInitialState extends WallpaperState{}
class WallpaperLoadingState extends WallpaperState{}
class WallpaperLoadedState extends WallpaperState{
  MainWallpaperApi wallModel;
  WallpaperLoadedState({required this.wallModel});
}
class WallpaperErrorState extends WallpaperState{
  String? errorMsg;
  WallpaperErrorState({required this.errorMsg});
}

class WallpaperInterNetErrorState extends WallpaperState{
  String? errorMsg;
  WallpaperInterNetErrorState({required this.errorMsg});
}