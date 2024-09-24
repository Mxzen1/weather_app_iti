import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather_model.dart';

class WeatherService {
  final String apiKey = '186b7da5f7cf43d0af5213224242409';
  
  Future<WeatherModel> fetchWeather(String city) async {
    final url = 'http://api.weatherapi.com/v1/current.json?key=$apiKey&q=$city&aqi=no';
    
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return WeatherModel.fromJson(data);
      } else {
        throw Exception('City not found');
      }
    } catch (error) {
      throw Exception('Failed to fetch weather data');
    }
  }
}
