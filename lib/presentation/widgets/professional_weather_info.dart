import 'package:flutter/material.dart';
import '../../data/models/weather_model.dart';

class ProfessionalWeatherInfo extends StatelessWidget {
  final WeatherModel weather;
  
  const ProfessionalWeatherInfo({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
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
                    Icons.analytics_outlined,
                    color: Color(0xFF6366F1),
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  'Phân tích chuyên nghiệp',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            
            // Professional metrics
            _buildProfessionalMetrics(isDark),
            
            const SizedBox(height: 20),
            
            // Weather conditions analysis
            _buildWeatherAnalysis(isDark),
          ],
        ),
      ),
    );
  }

  Widget _buildProfessionalMetrics(bool isDark) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildMetricCard(
                title: 'Chỉ số thoải mái',
                value: _getComfortIndex(),
                icon: Icons.sentiment_satisfied,
                color: const Color(0xFF10B981),
                isDark: isDark,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildMetricCard(
                title: 'Chỉ số gió',
                value: _getWindIndex(),
                icon: Icons.air,
                color: const Color(0xFF06B6D4),
                isDark: isDark,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildMetricCard(
                title: 'Chỉ số áp suất',
                value: _getPressureIndex(),
                icon: Icons.compress,
                color: const Color(0xFF8B5CF6),
                isDark: isDark,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildMetricCard(
                title: 'Chỉ số tầm nhìn',
                value: _getVisibilityIndex(),
                icon: Icons.visibility,
                color: const Color(0xFFF59E0B),
                isDark: isDark,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMetricCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
    required bool isDark,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark 
          ? Colors.white.withOpacity(0.05)
          : color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark 
            ? Colors.white.withOpacity(0.1)
            : color.withOpacity(0.3),
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: color,
              size: 20,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: isDark ? Colors.grey[400] : Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildWeatherAnalysis(bool isDark) {
    return Container(
      padding: const EdgeInsets.all(16),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Phân tích thời tiết',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : Colors.black87,
            ),
          ),
          const SizedBox(height: 12),
          _buildAnalysisItem(
            icon: Icons.thermostat,
            title: 'Nhiệt độ',
            description: _getTemperatureAnalysis(),
            isDark: isDark,
          ),
          const SizedBox(height: 8),
          _buildAnalysisItem(
            icon: Icons.water_drop,
            title: 'Độ ẩm',
            description: _getHumidityAnalysis(),
            isDark: isDark,
          ),
          const SizedBox(height: 8),
          _buildAnalysisItem(
            icon: Icons.air,
            title: 'Gió',
            description: _getWindAnalysis(),
            isDark: isDark,
          ),
        ],
      ),
    );
  }

  Widget _buildAnalysisItem({
    required IconData icon,
    required String title,
    required String description,
    required bool isDark,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          color: isDark ? Colors.grey[400] : Colors.grey[600],
          size: 16,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: TextStyle(
                fontSize: 14,
                color: isDark ? Colors.grey[300] : Colors.grey[700],
              ),
              children: [
                TextSpan(
                  text: '$title: ',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                ),
                TextSpan(text: description),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Analysis methods
  String _getComfortIndex() {
    final temp = weather.temperature;
    final humidity = weather.humidity;
    
    if (temp >= 20 && temp <= 26 && humidity >= 40 && humidity <= 60) {
      return 'Tuyệt vời';
    } else if (temp >= 18 && temp <= 28 && humidity >= 30 && humidity <= 70) {
      return 'Tốt';
    } else if (temp >= 15 && temp <= 30 && humidity >= 20 && humidity <= 80) {
      return 'Khá';
    } else {
      return 'Khó chịu';
    }
  }

  String _getWindIndex() {
    final speed = weather.windSpeed;
    
    if (speed < 1) return 'Lặng gió';
    if (speed < 3) return 'Nhẹ';
    if (speed < 7) return 'Vừa phải';
    if (speed < 12) return 'Mạnh';
    return 'Rất mạnh';
  }

  String _getPressureIndex() {
    final pressure = weather.pressure;
    
    if (pressure > 1020) return 'Cao';
    if (pressure > 1010) return 'Bình thường';
    return 'Thấp';
  }

  String _getVisibilityIndex() {
    final visibility = weather.visibility;
    
    if (visibility > 10000) return 'Tuyệt vời';
    if (visibility > 5000) return 'Tốt';
    if (visibility > 2000) return 'Khá';
    return 'Kém';
  }

  String _getTemperatureAnalysis() {
    final temp = weather.temperature;
    final feelsLike = weather.feelsLike;
    final diff = (feelsLike - temp).abs();
    
    if (diff < 1) {
      return 'Nhiệt độ cảm nhận gần với nhiệt độ thực tế';
    } else if (feelsLike > temp) {
      return 'Cảm giác nóng hơn ${diff.toStringAsFixed(1)}°C do độ ẩm cao';
    } else {
      return 'Cảm giác lạnh hơn ${diff.toStringAsFixed(1)}°C do gió';
    }
  }

  String _getHumidityAnalysis() {
    final humidity = weather.humidity;
    
    if (humidity < 30) return 'Không khí khô, có thể gây khó chịu';
    if (humidity < 50) return 'Độ ẩm thấp, thoải mái';
    if (humidity < 70) return 'Độ ẩm lý tưởng';
    if (humidity < 85) return 'Độ ẩm cao, hơi ẩm ướt';
    return 'Độ ẩm rất cao, khó chịu';
  }

  String _getWindAnalysis() {
    final speed = weather.windSpeed;
    final direction = weather.windDirectionText;
    
    if (speed < 1) return 'Không có gió, không khí tĩnh lặng';
    if (speed < 3) return 'Gió nhẹ từ hướng $direction';
    if (speed < 7) return 'Gió vừa phải từ hướng $direction';
    return 'Gió mạnh từ hướng $direction, cần chú ý';
  }
}
