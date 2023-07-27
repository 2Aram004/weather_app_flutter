import 'package:http/http.dart' as http;
import 'dart:convert';

class Weather {
  double? temp;
  String? weather;
  double? windSpeed;
  int? cloudiness;

  Weather.fromJson(Map<String, dynamic> json) {
    temp = json['main']['temp'] - 273 as double;
    var list = json['weather'] as List<dynamic>;
    weather = list[0]['main'];
    windSpeed = json['wind']['speed'];
    cloudiness = json['clouds']['all'];
  }
}

class WeatherApiClient {
  Future<Weather?>? getCurrentWeather(
      double? latitude, double? longitude) async {
    var endPoint = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=de25bea72da9df236c052e002b279fa6');
    var response = await http.get(endPoint);
    var body = jsonDecode(response.body);
    return Weather.fromJson(body);
  }
}
