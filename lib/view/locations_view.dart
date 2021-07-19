import 'package:calif_skate_map_proto_type_1/controller/weather_controller.dart';
import 'package:calif_skate_map_proto_type_1/widgets/city_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LocationsView extends StatelessWidget {
  final MainController controller = Get.find();
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
        itemCount: controller.data.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
            child: CityCard(
              cityName: controller.data[index].name,
              cityFlag: controller.data[index].flag,
              onPressed: () {
                controller.chooseCity(index);
                Get.offNamed("/home");
              },
            ),
          );
        },
      ),
    );
  }
}
