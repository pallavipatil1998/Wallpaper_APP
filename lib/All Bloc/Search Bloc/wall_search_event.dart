abstract class WallSearchEvent{}

class GetSerachWallEvent extends WallSearchEvent{
  String query;
  String? mColor;
  GetSerachWallEvent({required this.query,this.mColor});
}