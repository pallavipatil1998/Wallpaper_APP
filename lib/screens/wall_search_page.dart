import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallpaper_app/All%20Bloc/Search%20Bloc/wall_search_bloc.dart';
import 'package:wallpaper_app/All%20Bloc/Search%20Bloc/wall_search_event.dart';
import 'package:wallpaper_app/All%20Bloc/Search%20Bloc/wall_search_state.dart';
import 'package:wallpaper_app/screens/wallpaper_detail_page.dart';

import '../models/photos_model_2.dart';

class WallSearchPage extends StatefulWidget {
  String mQuery;
  String? mColor;

  WallSearchPage({required this.mQuery, this.mColor});

  @override
  State<WallSearchPage> createState() => _WallSearchPageState();
}

class _WallSearchPageState extends State<WallSearchPage> {
  List<PhotosModel> arrPhotos=[];

  int mPageNo = 1;
  late ScrollController mController;
  int totalResults = 0;
  bool isFirst = true;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    arrPhotos.clear();
   /* mController=ScrollController();
    mController.addListener((){});*/

    //or


    mController=ScrollController()..addListener((){
      if(mController.position.pixels==mController.position.maxScrollExtent){
        print("End of List");
        mPageNo++;

        context
            .read<WallSearchBloc>()
            .add(GetSerachWallEvent(query: widget.mQuery,mColor: widget.mColor,pageNo: mPageNo));

      }

    });

    context
        .read<WallSearchBloc>()
        .add(GetSerachWallEvent(query: widget.mQuery,mColor: widget.mColor));



  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.mQuery,
              style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: BlocListener<WallSearchBloc, WallSearchState>(
                listener: (_, state) {
                if (state is WallSearchLoadingState) {
                 ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text(mPageNo==1?"loading":"loding next page") ));
                } else if (state is WallSearchInterNetErrorState) {
                 ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${state.errorMsg}")));
                } else if (state is WallSearchErrorState) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${state.errorMsg}")));

                } else if (state is WallSearchLoadedState) {
                  totalResults=state.wallModel.total_results!;
                  arrPhotos.addAll(state.wallModel.photos!);
                  setState(() {});

                }

              },
                child: Column(
                  children: [
                    Text(
                      "$totalResults Wallpaper Available",
                      style: TextStyle(fontSize: 22, color: Colors.white),
                    ),
                    Expanded(
                      child: GridView.builder(
                          controller: mController,
                          itemCount: arrPhotos.length,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 9 /16,
                              crossAxisSpacing: 11,
                              mainAxisSpacing: 11),
                          itemBuilder: (ctx, index) {
                            return InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => WallpaperDetailPage(imgUrl:arrPhotos[index].src!.portrait! ),));
                              },
                              child: Container(
                                width: 200,height: 400,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                      arrPhotos[index].src!
                                          .portrait!,
                                    ),
                                  ),
                                ),
                              ),
                            );

                          }),
                    )
                  ],
                ),

              ),
            )
          ],
        ),
      ),
    ));
  }
}
