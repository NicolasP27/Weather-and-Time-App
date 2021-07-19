class City {
  String name;
  String flag;
  DateTime? date; // date Obj
  String? time; // Formatted time ex: 10:00 PM
  String? weather;
  int? timezone;
  int? sunrise; //UNIX timestamp
  int? sunset; //UNIX timestamp

  City({
    required this.name,
    required this.flag,
    this.date,
    this.time,
    this.weather,
    this.timezone,
    this.sunrise,
    this.sunset,
  });
}
