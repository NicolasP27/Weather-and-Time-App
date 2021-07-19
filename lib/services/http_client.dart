import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:calif_skate_map_proto_type_1/services/exceptions.dart';
import 'package:http/http.dart' as Http;

class HttpClient {
  static const TIME_OUT_DURATION = Duration(seconds: 15);

  Future<Map<String, dynamic>?> getCityDataByName(String cityName) async {
    const baseUrl = "https://api.openweathermap.org";
    const apiKey = "9aaa85272e6a6a88c445b1c5e1ebed39";
    String api = "/data/2.5/weather?q=$cityName&appid=$apiKey";

    try {
      Http.Response response =
          await Http.get(Uri.parse(baseUrl + api)).timeout(TIME_OUT_DURATION);
      return _processResponse(response);
    } on SocketException {
      //TODO customize the text as you prefer
      throw AppException(message: "Check Your Internet Connection");
    } on TimeoutException {
      //TODO customize the text as you prefer
      throw AppException(message: "Check Your Internet And Try Again Later");
    }
  }

  Future<int?> getCurrentUNIX() async {
    const baseUrl = "https://showcase.api.linx.twenty57.net";
    const api = "/UnixTime/tounixtimestamp?datetime=now";

    try {
      Http.Response response = await Http.get(Uri.parse(baseUrl + api));
      Map<String, dynamic>? responseBody = _processResponse(response);
      if (responseBody != null) {
        String unix = responseBody["UnixTimeStamp"];
        return int.parse(unix);
      }
    } on SocketException {
      //TODO customize the text as you prefer
      throw AppException(message: "Check Your Internet Connection");
    } on TimeoutException {
      //TODO customize the text as you prefer
      throw AppException(message: "Check Your Internet And Try Again Later");
    }
  }

  Map<String, dynamic>? _processResponse(Http.Response response) {
    switch (response.statusCode) {
      case 200:
        return jsonDecode(response.body);
      default:
        //TODO customize the text as you prefer
        throw AppException(message: "Something Went Wrong !");
    }
  }
}
