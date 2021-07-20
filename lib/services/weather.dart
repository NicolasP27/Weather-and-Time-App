import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'dart:convert';

import 'package:intl/intl.dart';

class WorldWeather{
  final appId = '9aaa85272e6a6a88c445b1c5e1ebed39';

  late String? time; //the time in that location
  late bool isDaytime; //true or false if daytime or not
  String? location; //location name for the UI

  late String? weather ; //the weather in that city
  String? city;//city for upi endpoint


  WorldWeather({@required this.city,});

  Future<void> getWeather() async{
    //make the request
    Response response = await get(
        Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$appId&units=imperial'));
    Map weatherdata = jsonDecode(response.body);

    String temp = weatherdata['main']['temp'].toString();
    int timezone = weatherdata['timezone'];
    DateTime now = DateTime.now().add(Duration(seconds: timezone - DateTime.now().timeZoneOffset.inSeconds));
    isDaytime = now.hour > 6 && now.hour < 20 ? true : false;
    time = DateFormat.jm().format(now);
    location = weatherdata['name'];
    print (temp);
    weather = temp.substring(0, 3) + ' °F';

  }

}
