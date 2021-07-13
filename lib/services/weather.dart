import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'dart:convert';








class WorldWeather{
  final appId = '9aaa85272e6a6a88c445b1c5e1ebed39';


  late String? weather ; //the weather in that city
  String? city;//city for upi endpoint







  WorldWeather({@required this.city,});

  Future<void> getWeather() async{
    //make the request
    Response response = await get(
        Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$appId&units=imperial'));
    Map weatherdata = jsonDecode(response.body);

    String temp = weatherdata['main']['temp'].toString();
    print (temp);

    weather = temp.substring(0, 3) + ' °F';









  }

}