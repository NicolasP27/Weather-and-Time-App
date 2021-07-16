import 'package:flutter/material.dart';

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Map timedata = {};
  Map weatherdata = {};

  @override
  Widget build(BuildContext context) {

    timedata = timedata.isNotEmpty ? timedata : ModalRoute.of(context)!.settings.arguments as Map;
    print(timedata);
    weatherdata = weatherdata.isNotEmpty ? weatherdata : ModalRoute.of(context)!.settings.arguments as Map;
    print(weatherdata);


    //set background
    String? bgImage = timedata['isDaytime'] ? 'day.png' : 'night.png';
    Color? bgColor = timedata['isDaytime'] ? Colors.blue : Colors.indigo[700];


    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/$bgImage'),
                fit: BoxFit.cover,
              )
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 120.0, 0, 0),
            child: Column(
              children: [
                TextButton.icon(
                  onPressed: () async {
                    Navigator.pushReplacementNamed(context, '/location');
                  },
                  style: TextButton.styleFrom(
                    primary: Colors.black,
                  ),
                  icon: Icon(
                    Icons.edit_location,
                    color: Colors.grey[300],
                  ),
                  label: Text(
                    'Edit Location',
                    style: TextStyle(
                      color: Colors.grey[300],
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      timedata['location'],
                      style: TextStyle(
                        fontSize: 28.0,
                        letterSpacing: 2,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
                Text(
                  timedata['time'],
                  style: TextStyle(
                    fontSize: 66.0,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 20.0),
                Text(
                  weatherdata['weather'],
                  style: TextStyle(
                    fontSize: 66.0,
                    color: Colors.amber,
                  ),
                ),
              ],
            ),
          ),
        ),


      ),
    );
  }
}
