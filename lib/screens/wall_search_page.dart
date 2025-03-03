import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallpaper_app/All%20Bloc/Search%20Bloc/wall_search_bloc.dart';
import 'package:wallpaper_app/All%20Bloc/Search%20Bloc/wall_search_event.dart';
import 'package:wallpaper_app/All%20Bloc/Search%20Bloc/wall_search_state.dart';

class WallSearchPage extends StatefulWidget {
  String mQuery;
  String? mColor;

  WallSearchPage({required this.mQuery, this.mColor});

  @override
  State<WallSearchPage> createState() => _WallSearchPageState();
}

class _WallSearchPageState extends State<WallSearchPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
              child: BlocBuilder<WallSearchBloc, WallSearchState>(builder: (_, state) {
                if (state is WallSearchLoadingState) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is WallSearchInterNetErrorState) {
                  return Text("${state.errorMsg}");
                } else if (state is WallSearchErrorState) {
                  return Text("${state.errorMsg}");
                } else if (state is WallSearchLoadedState) {
                  if(state.wallModel.photos!.isNotEmpty){
                    return Column(
                      children: [
                        Text(
                          "${state.wallModel.total_results} Wallpaper Available",
                          style: TextStyle(fontSize: 22, color: Colors.white),
                        ),
                        Expanded(
                          child: GridView.builder(
                              itemCount: state.wallModel.photos!.length,
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 9 /16,
                                  crossAxisSpacing: 11,
                                  mainAxisSpacing: 11),
                              itemBuilder: (ctx, index) {
                                return Container(
                                  width: 200,height: 400,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                        state.wallModel.photos![index].src!
                                            .portrait!,
                                      ),
                                    ),
                                  ),
                                );

                              }),
                        )
                      ],
                    );
                  }else{
                    return Center(child: Text("Data Not Found"),);
                  }
                }
                return Container();
              }),
            )
          ],
        ),
      ),
    ));
  }
}
