
import 'dart:math';

import 'package:flutter/material.dart';

class ScrollingLicenerControllerPage extends StatefulWidget {
  const ScrollingLicenerControllerPage({super.key});

  @override
  State<ScrollingLicenerControllerPage> createState() => _ScrollingLicenerControllerPageState();
}

class _ScrollingLicenerControllerPageState extends State<ScrollingLicenerControllerPage> {
  late ScrollController mController;
  List<Color> mColor=[
    Colors.blue,
    Colors.green,
    Colors.red,
    Colors.yellow,
    Colors.orange,
    Colors.black,
    Colors.deepPurple,
    Colors.pink,
    Colors.teal,
    Colors.deepOrange

  ];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mController=ScrollController();
   mController.addListener((){
    if(mController.position.pixels==mController.position.maxScrollExtent){
      print("End of List");
      for (int i = 0; i < 10; i++) {
        mColor.add(Colors
            .primaries[Random().nextInt(Colors.primaries.length - 1)]);
        setState(() {

        });
      }


    }

  }
  );


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
         title: Text("Scrolling"),
       ),

      body: GridView.builder(
        controller: mController,
        itemCount: mColor.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisSpacing: 11,crossAxisSpacing: 11,childAspectRatio: 9/16),
          itemBuilder: (_,index){
          return Container(
            color: mColor[index],
          );

          }
      ),

    );
  }
}
