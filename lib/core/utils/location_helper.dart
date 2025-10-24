class LocationHelper {
  static Future<String> getCurrentCity() async {
    // TODO: Tích hợp GPS, tạm thời trả về Hà Nội
    return 'Hanoi';
  }

  static Future<Map<String, double>?> getCurrentLocation() async {
    // TODO: Tích hợp GPS để lấy tọa độ thật
    // Tạm thời trả về tọa độ Hà Nội
    return {
      'lat': 21.0285,
      'lon': 105.8542,
    };
  }
}