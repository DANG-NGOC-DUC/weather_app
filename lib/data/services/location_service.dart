import '../../core/utils/location_helper.dart';

class LocationService {
  Future<String> getCurrentCity() async {
    return await LocationHelper.getCurrentCity();
  }

  Future<Map<String, double>?> getCurrentLocation() async {
    return await LocationHelper.getCurrentLocation();
  }
}