import 'package:flutter/material.dart';

class CityCard extends StatelessWidget {
  final String cityName;
  final String cityFlag;
  final Function onPressed;

  CityCard({
    required this.cityName,
    required this.cityFlag,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () {
          onPressed();
        },
        title: Text(cityName),
        leading: CircleAvatar(
          backgroundImage: AssetImage('assets/$cityFlag'),
        ),
      ),
    );
  }
}
