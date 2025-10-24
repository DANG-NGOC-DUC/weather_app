import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../core/constants/api_constants.dart';

class ApiService {
  Future<Map<String, dynamic>> fetchWeather(String city) async {
    final url =
        '${ApiConstants.baseUrl}?q=$city&appid=${ApiConstants.apiKey}&units=metric';
    
    try {
      final response = await http.get(Uri.parse(url));
      
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else if (response.statusCode == 401) {
        throw Exception('API key không hợp lệ. Vui lòng kiểm tra lại API key trong api_constants.dart');
      } else if (response.statusCode == 404) {
        throw Exception('Không tìm thấy thành phố "$city". Vui lòng kiểm tra lại tên thành phố.');
      } else {
        throw Exception('Lỗi server: ${response.statusCode}. Vui lòng thử lại sau.');
      }
    } catch (e) {
      if (e.toString().contains('SocketException') || e.toString().contains('HandshakeException')) {
        throw Exception('Không có kết nối internet. Vui lòng kiểm tra lại mạng.');
      }
      rethrow;
    }
  }

  Future<Map<String, dynamic>> fetchWeatherByCoordinates(double lat, double lon) async {
    final url =
        '${ApiConstants.baseUrl}?lat=$lat&lon=$lon&appid=${ApiConstants.apiKey}&units=metric';
    
    try {
      final response = await http.get(Uri.parse(url));
      
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else if (response.statusCode == 401) {
        throw Exception('API key không hợp lệ. Vui lòng kiểm tra lại API key trong api_constants.dart');
      } else {
        throw Exception('Lỗi server: ${response.statusCode}. Vui lòng thử lại sau.');
      }
    } catch (e) {
      if (e.toString().contains('SocketException') || e.toString().contains('HandshakeException')) {
        throw Exception('Không có kết nối internet. Vui lòng kiểm tra lại mạng.');
      }
      rethrow;
    }
  }

  Future<List<String>> getCitySuggestions(String query) async {
    // Danh sách các thành phố phổ biến ở Việt Nam và thế giới
    final List<String> cities = [
      'Hanoi', 'Ho Chi Minh City', 'Da Nang', 'Hai Phong', 'Can Tho',
      'London', 'Paris', 'Tokyo', 'New York', 'Los Angeles', 'Sydney',
      'Singapore', 'Bangkok', 'Seoul', 'Beijing', 'Shanghai', 'Mumbai',
      'Dubai', 'Istanbul', 'Moscow', 'Berlin', 'Madrid', 'Rome', 'Amsterdam',
      'Toronto', 'Vancouver', 'Mexico City', 'São Paulo', 'Buenos Aires',
      'Cairo', 'Lagos', 'Nairobi', 'Cape Town', 'Casablanca'
    ];
    
    if (query.isEmpty) return cities.take(10).toList();
    
    return cities
        .where((city) => city.toLowerCase().contains(query.toLowerCase()))
        .take(10)
        .toList();
  }
  
  // Mock data để test ứng dụng
  Map<String, dynamic> _getMockWeatherData(String city) {
    return {
      "name": city,
      "main": {
        "temp": 25.5,
        "feels_like": 27.2,
        "temp_min": 23.0,
        "temp_max": 28.0,
        "pressure": 1013,
        "humidity": 65
      },
      "weather": [
        {
          "main": "Clouds",
          "description": "few clouds",
          "icon": "02d"
        }
      ],
      "wind": {
        "speed": 3.5,
        "deg": 180
      },
      "sys": {
        "country": "VN",
        "sunrise": 1640995200,
        "sunset": 1641038400
      }
    };
  }
}
