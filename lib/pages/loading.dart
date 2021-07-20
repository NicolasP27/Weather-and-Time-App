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
    WorldWeather instance = WorldWeather(city:'guatemala',);
    await instance.getWeather();
    print('1');
    // WorldTime instance = WorldTime(location:'Guatemala City', flag: 'guatemala.png', url: 'America/Guatemala',  );
    // print('3');
    // await instance.getTime();
    Navigator.pushReplacementNamed(context, '/home', arguments: {
      'location': instance.location,
      'flag': 'guatemala.png',
      'time': instance.time,
      'isDaytime' : instance.isDaytime,
      'weather': instance.weather,
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
