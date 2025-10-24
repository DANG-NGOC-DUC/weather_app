import '../services/api_service.dart';
import '../models/weather_model.dart';

class WeatherRepository {
  final ApiService apiService;
  WeatherRepository({required this.apiService});

  Future<WeatherModel> getWeather(String city) async {
    final data = await apiService.fetchWeather(city);
    return WeatherModel.fromJson(data);
  }

  Future<WeatherModel> getWeatherByLocation(double lat, double lon) async {
    final data = await apiService.fetchWeatherByCoordinates(lat, lon);
    return WeatherModel.fromJson(data);
  }

  Future<List<String>> getCitySuggestions(String query) async {
    return await apiService.getCitySuggestions(query);
  }
}
