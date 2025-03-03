abstract class WallpaperEvent{}

class WallGetSerachEvent extends WallpaperEvent{
  String query;
  WallGetSerachEvent({required this.query});
}

class WallGetTrandingEvent extends WallpaperEvent{}