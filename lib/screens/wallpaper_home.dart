import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallpaper_app/screens/wall_search_page.dart';
import 'package:wallpaper_app/screens/wallpaper_detail_page.dart';
import '../All Bloc/tranding_wall_bloc/wallpaper_bloc.dart';
import '../All Bloc/tranding_wall_bloc/wallpaper_event.dart';
import '../All Bloc/tranding_wall_bloc/wallpaper_state.dart';
import '../models/main_Wallpaper_api_3.dart';

class WallpaperHome extends StatefulWidget {
  const WallpaperHome({super.key});

  @override
  State<WallpaperHome> createState() => _WallpaperHomeState();
}

class _WallpaperHomeState extends State<WallpaperHome> {
  var queryController = TextEditingController();
  var searchQuery = "nature";
  var searchColor = "";
  List colorList = [
    {"color": Colors.blue, "code": "2196F3"},
    {"color": Colors.deepOrange, "code": "FF5722"},
    {"color": Colors.black, "code": "000000"},
    {"color": Colors.white, "code": "ffffff"},
    {"color": Colors.blue, "code": "blue"},
    {"color": Colors.green, "code": "4CAF50"},
    {"color": Colors.yellow, "code": "FFEB3B"},
  ];

  List<Map<String, dynamic>> categoriesName = [
    {
      'name': "Nature",
      'img_cat': 'assets/images/natural/img_natural12.jpg',
    },
    {
      'name': "Flowers",
      'img_cat': 'assets/images/flower/img_flower23.avif',
    },
    {
      'name': "Sports",
      'img_cat': 'assets/images/sports/img_sports20.avif',
    },
    {
      'name': "Film",
      'img_cat': 'assets/images/film/img_film11.webp',
    },
    {
      'name': "Street Photography",
      'img_cat': 'assets/images/street/img_street10.avif',
    },
    {
      'name': "Animals",
      'img_cat': 'assets/images/animals/img_animals14.avif',
    },
    {
      'name': "Fashion & Beauty",
      'img_cat': 'assets/images/street/img_street15.avif',
    },
    {
      'name': "Food & Drink",
      'img_cat': 'assets/images/food/img_food18.avif',
    },
    {'name': "Travel", 'img_cat': 'assets/images/street/img_street18.avif'},
    {
      'name': "Health & Wellness",
      'img_cat': 'assets/images/sports/img_sports19.avif'
    },
    {
      'name': "Arts & Culture",
      'img_cat': 'assets/images/film/img_film6.avif',
    },
    // {'name': "Flowers", 'img_cat': 'assets/images/img_natural13.jpg'},
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<WallpaperBloc>().add(WallGetTrandingEvent());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xffE8D7DA),
                    Color(0xffA0D3D6),
                  ],
                ),
              ),
            ),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 25),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.only(top: 30),
                        decoration: BoxDecoration(
                          color: const Color(0xffDBEBF1),
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 8,
                              spreadRadius: 1,
                            )
                          ],
                        ),
                        child: TextField(
                          controller: queryController,
                          decoration: InputDecoration(
                            hintText: 'Find Wallpaper..',
                            hintStyle: TextStyle(
                                color: Color.fromARGB(255, 152, 152, 152),
                                fontWeight: FontWeight.w800),
                            suffixIcon: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => WallSearchPage(
                                              mQuery: queryController.text
                                                  .toString())));
                                },
                                child: Icon(Icons.image_search)),
                            suffixIconColor: Color.fromARGB(255, 172, 172, 172),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xffDBEBF1),
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xffDBEBF1),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      "Best of the month",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 350,
                      child: BlocBuilder<WallpaperBloc, WallpaperState>(
                          builder: (ctx, state) {
                        if (state is WallpaperLoadingState) {
                          return Center(child: CircularProgressIndicator());
                        } else if (state is WallpaperInterNetErrorState) {
                          return Center(child: Text(state.errorMsg!));
                        } else if (state is WallpaperErrorState) {
                          return Center(child: Text("${state.errorMsg}"));
                        } else if (state is WallpaperLoadedState) {
                          return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: state.wallModel.photos!.length,
                              itemBuilder: (ctx, index) {
                                var eachWall = state
                                    .wallModel.photos![index].src!.portrait!;
                                return InkWell(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => WallpaperDetailPage(imgUrl: eachWall),));
                                  },
                                  child: Container(
                                    margin: EdgeInsets.all(20),
                                    height: 200,
                                    width: 200,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(11),
                                      image: DecorationImage(
                                          image: NetworkImage(eachWall),
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                                );
                              });
                        }

                        return Container();
                      }),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      "The Color Tone",
                      style:
                          TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 50,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: colorList.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => WallSearchPage(
                                            mQuery:
                                                queryController.text.isNotEmpty
                                                    ? queryController.text
                                                        .toString()
                                                    : "car",
                                            mColor: colorList[index]["code"],
                                          )));
                            },
                            child: Container(
                              margin: const EdgeInsets.only(right: 10),
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                  color: colorList[index]["color"] as Color,
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Categories',
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 500,
                      child: GridView.builder(
                          itemCount: categoriesName.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2, childAspectRatio: 16 /9),
                          itemBuilder: (ctx, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => WallSearchPage(
                                          mQuery: categoriesName[index]
                                              ["name"])),
                                );
                              },
                              child: Stack(
                                children: [
                                  Container(
                                    height: 400,
                                    width: 200,
                                    margin:
                                        EdgeInsets.only(right: 15, bottom: 10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                            image: AssetImage(
                                                categoriesName[index]
                                                    ["img_cat"]),
                                            fit: BoxFit.cover)),
                                    child: Center(
                                      child: Text(
                                        "${categoriesName[index]["name"]}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontSize: 16),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
