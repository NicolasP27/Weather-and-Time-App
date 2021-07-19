import 'package:calif_skate_map_proto_type_1/controller/weather_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class HomeView extends StatelessWidget {
  final MainController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(children: [
          Obx(
            () => Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage(
                    'assets/${controller.isDayTime ? "day.png" : "night.png"}'),
                fit: BoxFit.cover,
              )),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 120.0, 0, 0),
                child: Column(
                  children: [
                    TextButton.icon(
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
                      onPressed: () {
                        Get.offNamed("/location");
                      },
                    ),
                    SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Obx(
                          () => Text(
                            controller.data[controller.selectedCityIndex].name,
                            style: TextStyle(
                              fontSize: 28.0,
                              letterSpacing: 2,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.0),
                    Obx(
                      () => Text(
                        controller.data[controller.selectedCityIndex].time ??
                            "Loading..", //TODO customize the text as you prefer
                        style: TextStyle(
                          fontSize: 66.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Obx(
                      () => Text(
                        controller.data[controller.selectedCityIndex].weather ??
                            "Loading..", //TODO customize the text as you prefer
                        style: TextStyle(
                          fontSize: 66.0,
                          color: Colors.amber,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Obx(
            () => Visibility(
              visible: controller.isLoading,
              child: Container(
                color: Colors.blue[900],
                child: SpinKitFoldingCube(
                  color: Colors.white,
                  size: 80.0,
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
