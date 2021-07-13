import 'package:flutter/material.dart';
import 'package:calif_skate_map_proto_type_1/pages/home.dart';
import 'package:calif_skate_map_proto_type_1/pages/loading.dart';
import 'package:calif_skate_map_proto_type_1/pages/choose_location.dart';

void main() => runApp(MaterialApp(
  initialRoute: '/',
  routes: {
    '/':(context) => Loading(),
    '/home': (context) => Home(),
    '/location': (context) => ChooseLocation(),
  },
));