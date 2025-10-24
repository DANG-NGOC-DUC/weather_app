import 'package:flutter/material.dart';
import '../../data/models/weather_model.dart';

class HourlyForecastWidget extends StatelessWidget {
  final WeatherModel weather;
  
  const HourlyForecastWidget({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    // Tạo dữ liệu giả cho hourly forecast (vì API miễn phí không có hourly data)
    final hourlyData = _generateHourlyData();
    
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E293B) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF6366F1).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.schedule,
                    color: Color(0xFF6366F1),
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  'Dự báo theo giờ',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            
            // Hourly forecast list
            SizedBox(
              height: 120,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: hourlyData.length,
                itemBuilder: (context, index) {
                  final hourData = hourlyData[index];
                  return _buildHourlyItem(
                    hourData: hourData,
                    isDark: isDark,
                    isFirst: index == 0,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHourlyItem({
    required Map<String, dynamic> hourData,
    required bool isDark,
    required bool isFirst,
  }) {
    return Container(
      width: 80,
      margin: EdgeInsets.only(
        right: isFirst ? 0 : 12,
      ),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark 
          ? Colors.white.withOpacity(0.05)
          : const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark 
            ? Colors.white.withOpacity(0.1)
            : Colors.grey.withOpacity(0.2),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Time
          Text(
            hourData['time'],
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.grey[300] : Colors.grey[600],
            ),
          ),
          
          // Weather icon
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: isDark 
                ? Colors.white.withOpacity(0.1)
                : Colors.blue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                'https://openweathermap.org/img/wn/${hourData['icon']}@2x.png',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    decoration: BoxDecoration(
                      color: isDark 
                        ? Colors.white.withOpacity(0.1)
                        : Colors.blue.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      _getWeatherIcon(hourData['condition']),
                      size: 20,
                      color: isDark ? Colors.white : Colors.blue,
                    ),
                  );
                },
              ),
            ),
          ),
          
          // Temperature
          Text(
            '${hourData['temp'].toStringAsFixed(0)}°',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : Colors.black87,
            ),
          ),
          
          // Precipitation chance (if available)
          if (hourData['precipitation'] != null)
            Text(
              '${hourData['precipitation']}%',
              style: TextStyle(
                fontSize: 10,
                color: isDark ? Colors.grey[400] : Colors.grey[500],
              ),
            ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _generateHourlyData() {
    final now = DateTime.now();
    final baseTemp = weather.temperature;
    final baseIcon = weather.icon;
    
    List<Map<String, dynamic>> hourlyData = [];
    
    // Tạo dữ liệu cho 24 giờ tiếp theo, mỗi 2 giờ
    for (int i = 0; i < 12; i++) {
      final hour = now.add(Duration(hours: i * 2));
      final tempVariation = (i % 3 - 1) * 2.0; // Biến thiên nhiệt độ
      final temp = baseTemp + tempVariation;
      
      // Thay đổi icon dựa trên thời gian
      String icon = baseIcon;
      if (hour.hour >= 6 && hour.hour < 12) {
        icon = '01d'; // Nắng sáng
      } else if (hour.hour >= 12 && hour.hour < 18) {
        icon = '02d'; // Ít mây chiều
      } else if (hour.hour >= 18 && hour.hour < 22) {
        icon = '03d'; // Mây chiều
      } else {
        icon = '01n'; // Đêm
      }
      
      hourlyData.add({
        'time': '${hour.hour.toString().padLeft(2, '0')}:00',
        'temp': temp,
        'icon': icon,
        'condition': _getWeatherCondition(icon),
        'precipitation': i % 4 == 0 ? (i * 5) % 30 : null, // Xác suất mưa
      });
    }
    
    return hourlyData;
  }

  String _getWeatherCondition(String icon) {
    if (icon.contains('01')) return 'Nắng';
    if (icon.contains('02') || icon.contains('03')) return 'Ít mây';
    if (icon.contains('04')) return 'Nhiều mây';
    if (icon.contains('09') || icon.contains('10')) return 'Mưa';
    if (icon.contains('11')) return 'Dông';
    if (icon.contains('13')) return 'Tuyết';
    if (icon.contains('50')) return 'Sương mù';
    return 'Không xác định';
  }

  IconData _getWeatherIcon(String condition) {
    switch (condition) {
      case 'Nắng':
        return Icons.wb_sunny;
      case 'Ít mây':
        return Icons.wb_cloudy;
      case 'Nhiều mây':
        return Icons.cloud;
      case 'Mưa':
        return Icons.grain;
      case 'Dông':
        return Icons.flash_on;
      case 'Tuyết':
        return Icons.ac_unit;
      case 'Sương mù':
        return Icons.blur_on;
      default:
        return Icons.wb_sunny;
    }
  }
}

