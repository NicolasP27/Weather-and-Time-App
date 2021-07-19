import 'package:calif_skate_map_proto_type_1/bindings/bindings.dart';
import 'package:calif_skate_map_proto_type_1/view/home_view.dart';
import 'package:calif_skate_map_proto_type_1/view/locations_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: AppBindings(),
      initialRoute: "/home",
      routes: {
        '/home': (context) => HomeView(),
        '/location': (context) => LocationsView(),
      },
    );
  }
}
