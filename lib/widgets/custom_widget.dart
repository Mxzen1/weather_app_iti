import 'package:flutter/material.dart';
import '../services/weather_services.dart';
import '../models/weather_model.dart';

class WeatherHomePage extends StatefulWidget {
  @override
  _WeatherHomePageState createState() => _WeatherHomePageState();
}

class _WeatherHomePageState extends State<WeatherHomePage> {
  final TextEditingController _controller = TextEditingController();
  WeatherModel? _weatherData;
  bool _loading = false;
  String _errorMessage = '';

  final WeatherService _weatherService = WeatherService();

  Future<void> _fetchWeather(String city) async {
    setState(() {
      _loading = true;
      _errorMessage = '';
    });

    try {
      WeatherModel weather = await _weatherService.fetchWeather(city);
      setState(() {
        _weatherData = weather;
      });
    } catch (error) {
      setState(() {
        _errorMessage = error.toString();
      });
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  
  Color _getBackgroundColor(String description) {
    description = description.toLowerCase();
    if (description.contains('sunny') || description.contains('clear')) {
      return Colors.orangeAccent;  // Sunny weather
    } else if (description.contains('rain')) {
      return Colors.blueGrey;  // Rainy weather
    } else if (description.contains('cloud') || description.contains('overcast')) {
      return Colors.grey;  // Cloudy or Overcast weather
    } else if (description.contains('snow')) {
      return Colors.lightBlueAccent;  // Snowy weather
    } else if (description.contains('thunder')) {
      return Colors.deepPurpleAccent;  // Thunderstorm
    } else {
      return Colors.blue;  // Default color
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Enter city name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _fetchWeather(_controller.text);
              },
              child: Text('Search'),
            ),
            SizedBox(height: 20),

            if (_loading)
              CircularProgressIndicator(),

            if (_errorMessage.isNotEmpty)
              Text(
                _errorMessage,
                style: TextStyle(color: Colors.red),
              ),

            if (_weatherData != null && _errorMessage.isEmpty)
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: _getBackgroundColor(_weatherData!.description),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Text(
                      'Temperature: ${_weatherData!.temperature}°C',
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Description: ${_weatherData!.description}',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Min Temp: ${_weatherData!.minTemp}°C',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Max Temp: ${_weatherData!.maxTemp}°C',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
