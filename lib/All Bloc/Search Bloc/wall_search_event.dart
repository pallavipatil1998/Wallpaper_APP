abstract class WallSearchEvent{}

class GetSerachWallEvent extends WallSearchEvent{
  String query;
  String? mColor;
  int? pageNo;
  GetSerachWallEvent({required this.query,this.mColor,this.pageNo});
}