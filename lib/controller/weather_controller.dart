import 'dart:async';

import 'package:calif_skate_map_proto_type_1/data/data.dart';
import 'package:calif_skate_map_proto_type_1/model/city.dart';
import 'package:calif_skate_map_proto_type_1/services/exceptions.dart';
import 'package:calif_skate_map_proto_type_1/services/http_client.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class MainController extends GetxController {
  HttpClient _client = HttpClient();
  Timer? timer;

  RxInt _selectedCityIndex = 0.obs;
  RxBool _isLoading = false.obs;
  RxBool _isDayTime = true.obs;

  int get selectedCityIndex => _selectedCityIndex.value;
  bool get isLoading => _isLoading.value;
  bool get isDayTime => _isDayTime.value;

  var data = cities.obs;

  @override
  void onInit() {
    super.onInit();
    chooseCity(selectedCityIndex);
  }

  void chooseCity(int index) async {
    _isLoading.value = true;
    _selectedCityIndex.value = index;
    City? _currentCityInstance = data[index];

    _currentCityInstance =
        await _updateCityData(_currentCityInstance).catchError(_handleError);

    if (_currentCityInstance!.time != null) {
      _checkDayOrNight(_currentCityInstance);
      _startTimer(_currentCityInstance);
    }

    _isLoading.value = false;
  }

  Future<City?> _updateCityData(City city) async {
    String validCityName = city.name.replaceAll(" ", "+").toLowerCase();
    Map<String, dynamic>? response =
        await _client.getCityDataByName(validCityName);
    if (response != null) {
      String weatherDescription = response["weather"][0]["description"];
      int timezone = response["timezone"];
      int sunset = response["sys"]["sunset"];
      int sunrise = response["sys"]["sunrise"];
      city.weather = weatherDescription;
      city.sunset = sunset;
      city.sunrise = sunrise;
      city.timezone = timezone;
      DateTime time =
          await _calculateLocalTime(city.timezone!).catchError(_handleError);
      city.date = time;
      city.time = _formatTime(time);
      return city;
    }
  }

  Future<DateTime> _calculateLocalTime(int cityTimezone) async {
    //calculates time by adding the timezone difference in seconds to the global UTC / GMt
    // you can use the device time to calculate the UTC like comment below
    // DateTime utc = DateTime.now().toUtc();
    int? unix = await _client.getCurrentUNIX();
    DateTime utc;
    if (unix == null) {
      utc = DateTime.now().toUtc();
    } else {
      utc = DateTime.fromMillisecondsSinceEpoch(unix * 1000).toUtc();
    }
    DateTime time = utc.add(Duration(seconds: cityTimezone));
    return time;
  }

  void _startTimer(City city) {
    if (timer != null) {
      timer!.cancel();
    }
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      city.date = city.date!.add(Duration(seconds: 1));
      city.time = _formatTime(city.date!);
      _checkDayOrNight(city);
      data.refresh();
    });
  }

  void _checkDayOrNight(City city) {
    DateTime sunset = DateTime.fromMillisecondsSinceEpoch(city.sunset! * 1000)
        .toUtc()
        .add(Duration(seconds: city.timezone!));

    DateTime sunrise = DateTime.fromMillisecondsSinceEpoch(city.sunrise! * 1000)
        .toUtc()
        .add(Duration(seconds: city.timezone!));
    if (city.date!.isAfter(sunrise) && city.date!.isBefore(sunset)) {
      _isDayTime.value = true;
    } else {
      _isDayTime.value = false;
    }
  }

  String _formatTime(DateTime time) {
    return DateFormat('hh:mm a').format(time);
  }

  void _handleError(Object error) {
    //TODO handle errors as you prefer
    // you can give every error a code and handle it differently
    // switch(error.code){
    //   case 0:
    //   case 1:
    //   default:
    // }
    if (error is AppException) {
      _isLoading.value = false;
      _showErrorDialog(error);
    }
  }

  void _showErrorDialog(AppException error) {
    Get.defaultDialog(title: "Error", content: Text("${error.message}"));
  }

  @override
  void onClose() {
    if (timer != null) {
      timer!.cancel();
    }
    super.onClose();
  }
}
