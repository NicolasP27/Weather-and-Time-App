import 'package:calif_skate_map_proto_type_1/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:calif_skate_map_proto_type_1/services/time.dart';

class ChooseLocation extends StatefulWidget {


  @override
  _ChooseLocationState createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {

  List<WorldTime> timelocations = [
    WorldTime(url: 'Europe/London', location: 'London', flag: 'uk.png'),
    WorldTime(url: 'Europe/Berlin', location: 'Athens', flag: 'greece.png'),
    WorldTime(url: 'Africa/Cairo', location: 'Cairo', flag: 'egypt.png'),
    WorldTime(url: 'Africa/Nairobi', location: 'Nairobi', flag: 'kenya.png'),
    WorldTime(url: 'America/Chicago', location: 'Chicago', flag: 'usa.png'),
    WorldTime(url: 'America/New_York', location: 'New York', flag: 'usa.png'),
    WorldTime(url: 'Asia/Seoul', location: 'Seoul', flag: 'south_korea.png'),
    WorldTime(url: 'Asia/Jakarta', location: 'Jakarta', flag: 'indonesia.png'),
    WorldTime(url: 'America/Los_Angeles', location: 'Los Angeles', flag: 'usa.png')
  ];

  List <WorldWeather> weatherlocations=[
    WorldWeather(city: 'London'),
    WorldWeather(city: 'Berlin'),
    WorldWeather(city: 'Cairo'),
    WorldWeather(city: 'Nairobi'),
    WorldWeather(city: 'Chicago'),
    WorldWeather(city: 'New+York'),
    WorldWeather(city: 'Seoul'),
    WorldWeather(city: 'Jakarta'),
    WorldWeather(city: 'Los+Angeles'),


  ];


  void updateTime(index) async {
    WorldTime instance = timelocations[index];
    await instance.getTime();
    //navigate to home screen
    Navigator.pop(context, {
      'location': instance.location,
      'flag': instance.flag,
      'time': instance.time,
      'isDaytime' : instance.isDaytime,
    });

  }


  void updateWeather(index) async{
    WorldWeather instance = weatherlocations[index];
    await instance.getWeather();
    //navigate to home screen
    Navigator.pop(context, {
      'weather': instance.weather,
    });
  }
  void setupEverything(index) async {
    WorldTime instance = timelocations[index];
    await instance.getTime();
    WorldWeather instance2 = weatherlocations[index];
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text('Choose a Location'),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: timelocations.length,
        itemBuilder: (context, index){
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
            child: Card(
              child: ListTile(
                onTap: (){
                  // updateTime(index);
                  // updateWeather(index);
                  setupEverything(index);
                },
                title: Text(timelocations[index].location.toString()),
                leading: CircleAvatar(
                  backgroundImage: AssetImage('assets/${timelocations[index].flag}'),
                ),
              ),
            ),
          );
        },
      ),



    );
  }
}
