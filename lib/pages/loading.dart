import 'package:calif_skate_map_proto_type_1/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:calif_skate_map_proto_type_1/services/time.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}


class _LoadingState extends State<Loading> {

  void setupWorldTime() async {
    WorldTime instance = WorldTime(location:'Guatemala City', flag: 'guatemala.png', url: 'America/Guatemala',  );
    await instance.getTime();
    Navigator.pushReplacementNamed(context, '/home', arguments: {
      'location': instance.location,
      'flag': instance.flag,
      'time': instance.time,
      'isDaytime' : instance.isDaytime,
    });

  }

  void setupWorldWeather() async{
    WorldWeather instance = WorldWeather(city:'guatemala',);
    await instance.getWeather();
    Navigator.pushReplacementNamed(context, '/home', arguments: {
      'weather': instance.weather,
    });
  }

  void setupEverything() async {
    WorldTime instance = WorldTime(location:'Guatemala City', flag: 'guatemala.png', url: 'America/Guatemala',  );
    await instance.getTime();
    WorldWeather instance2 = WorldWeather(city:'guatemala',);
    await instance2.getWeather();
    Navigator.pushReplacementNamed(context, '/home', arguments: {
      'location': instance.location,
      'flag': instance.flag,
      'time': instance.time,
      'isDaytime' : instance.isDaytime,
      'weather': instance2.weather,
    });
  }

  @override
  void initState() {
    super.initState();
    // setupWorldTime();
    // setupWorldWeather();
    setupEverything();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      body: Center(
        child: SpinKitFoldingCube(
          color: Colors.white,
          size: 80.0,
        ),

      ),
    );
  }
}
