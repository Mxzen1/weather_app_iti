class WeatherModel {
  final double temperature;
  final String description;
  final double minTemp;
  final double maxTemp;

  WeatherModel({
    required this.temperature,
    required this.description,
    required this.minTemp,
    required this.maxTemp,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    double currentTemp = json['current']['temp_c'];
    
 
    return WeatherModel(
      temperature: currentTemp,
      description: json['current']['condition']['text'],
      minTemp: currentTemp - 3,
      maxTemp: currentTemp + 3,
    );
  }
}
