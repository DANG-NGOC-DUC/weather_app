class WeatherModel {
  final String cityName;
  final String country;
  final double temperature;
  final double feelsLike;
  final double tempMin;
  final double tempMax;
  final int humidity;
  final int pressure;
  final double windSpeed;
  final int windDirection;
  final String description;
  final String mainWeather;
  final String icon;
  final int sunrise;
  final int sunset;
  final int visibility;
  final double uvIndex;

  WeatherModel({
    required this.cityName,
    required this.country,
    required this.temperature,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.humidity,
    required this.pressure,
    required this.windSpeed,
    required this.windDirection,
    required this.description,
    required this.mainWeather,
    required this.icon,
    required this.sunrise,
    required this.sunset,
    required this.visibility,
    required this.uvIndex,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      cityName: json['name'] ?? 'Unknown',
      country: json['sys']['country'] ?? 'Unknown',
      temperature: (json['main']['temp'] as num).toDouble(),
      feelsLike: (json['main']['feels_like'] as num).toDouble(),
      tempMin: (json['main']['temp_min'] as num).toDouble(),
      tempMax: (json['main']['temp_max'] as num).toDouble(),
      humidity: json['main']['humidity'] ?? 0,
      pressure: json['main']['pressure'] ?? 0,
      windSpeed: (json['wind']['speed'] as num).toDouble(),
      windDirection: json['wind']['deg'] ?? 0,
      description: json['weather'][0]['description'] ?? 'Unknown',
      mainWeather: json['weather'][0]['main'] ?? 'Unknown',
      icon: json['weather'][0]['icon'] ?? '01d',
      sunrise: json['sys']['sunrise'] ?? 0,
      sunset: json['sys']['sunset'] ?? 0,
      visibility: json['visibility'] ?? 0,
      uvIndex: 0.0, // UV index không có trong API miễn phí
    );
  }

  // Helper methods
  String get windDirectionText {
    if (windDirection >= 337.5 || windDirection < 22.5) return 'Bắc';
    if (windDirection >= 22.5 && windDirection < 67.5) return 'Đông Bắc';
    if (windDirection >= 67.5 && windDirection < 112.5) return 'Đông';
    if (windDirection >= 112.5 && windDirection < 157.5) return 'Đông Nam';
    if (windDirection >= 157.5 && windDirection < 202.5) return 'Nam';
    if (windDirection >= 202.5 && windDirection < 247.5) return 'Tây Nam';
    if (windDirection >= 247.5 && windDirection < 292.5) return 'Tây';
    if (windDirection >= 292.5 && windDirection < 337.5) return 'Tây Bắc';
    return 'Không xác định';
  }

  String get formattedSunrise {
    final date = DateTime.fromMillisecondsSinceEpoch(sunrise * 1000);
    return '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }

  String get formattedSunset {
    final date = DateTime.fromMillisecondsSinceEpoch(sunset * 1000);
    return '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }

  String get formattedVisibility {
    if (visibility >= 1000) {
      return '${(visibility / 1000).toStringAsFixed(1)} km';
    }
    return '$visibility m';
  }
}