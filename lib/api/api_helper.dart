import 'dart:convert';
import 'dart:io';

import 'package:wallpaper_app/api/my_exception.dart';
import 'package:wallpaper_app/api/urls.dart';

import '../models/main_Wallpaper_api_3.dart';
import 'package:http/http.dart'as http;

class ApiHelper{
  
  Future<dynamic> getApi({required String url,Map<String,String>? mHeader})async{
    try{
      var res= await http.get(Uri.parse(url),
          headers: mHeader ??{"Authorization": "nXWH9BLpCYtVtyjDTbJB3Hf20uneSxZcYisVLVmNDV4PamGm6EeVDgZm"});
      // print("RES body: ${res.statusCode}");

      return returnDatabaseResponse(res);

    } on SocketException{
      throw FetchDataException(body: "InternetError");
    }

  }

  //func
  dynamic returnDatabaseResponse(http.Response res){
    switch(res.statusCode){
      case 200:
        var data=res.body;
        return jsonDecode(data);

      case 401:
        throw UnAuthorisedException(body: res.body.toString());

      case 500:
      default:
        throw FetchDataException(body: res.body);
    }

  }


}