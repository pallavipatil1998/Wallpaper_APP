import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallpaper_app/bloc/wallpaper_bloc.dart';
import 'package:wallpaper_app/bloc/wallpaper_event.dart';
import 'package:wallpaper_app/bloc/wallpaper_state.dart';

import '../models/main_Wallpaper_api_3.dart';

class WallpaperHome extends StatefulWidget {
  const WallpaperHome({super.key});

  @override
  State<WallpaperHome> createState() => _WallpaperHomeState();
}

class _WallpaperHomeState extends State<WallpaperHome> {
  late Future<MainWallpaperApi> data;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<WallpaperBloc>().add(WallGetTrandingEvent());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Wallpapers"),),
      body: BlocBuilder<WallpaperBloc,WallpaperState>(builder: (ctx,state){
        if(state is WallpaperLoadingState){
          return Center(child: CircularProgressIndicator());
        }else if(state is WallpaperErrorState){
          return Center(child: Text("${state.errorMsg}"));
        }else if(state is WallpaperLoadedState){
          return ListView.builder(
            itemCount: state.wallModel.photos!.length ,
              itemBuilder: (ctx,index){
                var eachWall=state.wallModel.photos![index].src!.portrait!;
              return Container(
                margin: EdgeInsets.all(20),
                height: 200,width: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(11),
                  image: DecorationImage(image: NetworkImage(eachWall),fit: BoxFit.cover),
                ),
              );
              }
              );
        }

      return Container();
      }
      ),
    );
  }
}
