import 'package:flutter/material.dart';
import '../../data/models/weather_model.dart';

class WeatherDetails extends StatelessWidget {
  final WeatherModel weather;
  
  const WeatherDetails({super.key, required this.weather});

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
                    Icons.info_outline,
                    color: Color(0xFF6366F1),
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  'Thông tin chi tiết',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            
            // Weather info grid
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.3,
              children: [
                _buildDetailCard(
                  context: context,
                  icon: Icons.location_city,
                  title: 'Thành phố',
                  value: '${weather.cityName}, ${weather.country}',
                  color: const Color(0xFF3B82F6),
                  isDark: isDark,
                ),
                _buildDetailCard(
                  context: context,
                  icon: Icons.thermostat,
                  title: 'Nhiệt độ',
                  value: '${weather.temperature.toStringAsFixed(1)}°C',
                  color: const Color(0xFFEF4444),
                  isDark: isDark,
                ),
                _buildDetailCard(
                  context: context,
                  icon: Icons.wb_sunny,
                  title: 'Cảm giác như',
                  value: '${weather.feelsLike.toStringAsFixed(1)}°C',
                  color: const Color(0xFFF59E0B),
                  isDark: isDark,
                ),
                _buildDetailCard(
                  context: context,
                  icon: Icons.thermostat_outlined,
                  title: 'Nhiệt độ min/max',
                  value: '${weather.tempMin.toStringAsFixed(1)}°/${weather.tempMax.toStringAsFixed(1)}°',
                  color: const Color(0xFF10B981),
                  isDark: isDark,
                ),
                _buildDetailCard(
                  context: context,
                  icon: Icons.water_drop,
                  title: 'Độ ẩm',
                  value: '${weather.humidity}%',
                  color: const Color(0xFF06B6D4),
                  isDark: isDark,
                ),
                _buildDetailCard(
                  context: context,
                  icon: Icons.compress,
                  title: 'Áp suất',
                  value: '${weather.pressure} hPa',
                  color: const Color(0xFF8B5CF6),
                  isDark: isDark,
                ),
                _buildDetailCard(
                  context: context,
                  icon: Icons.air,
                  title: 'Gió',
                  value: '${weather.windSpeed.toStringAsFixed(1)} m/s ${weather.windDirectionText}',
                  color: const Color(0xFF84CC16),
                  isDark: isDark,
                ),
                _buildDetailCard(
                  context: context,
                  icon: Icons.visibility,
                  title: 'Tầm nhìn',
                  value: weather.formattedVisibility,
                  color: const Color(0xFFF97316),
                  isDark: isDark,
                ),
              ],
            ),
            
            const SizedBox(height: 20),
            
            // Additional info section
            Container(
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
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildMiniInfo(
                        icon: Icons.wb_sunny_outlined,
                        label: 'Mặt trời mọc',
                        value: weather.formattedSunrise,
                        isDark: isDark,
                      ),
                      _buildMiniInfo(
                        icon: Icons.wb_twilight,
                        label: 'Mặt trời lặn',
                        value: weather.formattedSunset,
                        isDark: isDark,
                      ),
                      _buildMiniInfo(
                        icon: Icons.cloud,
                        label: 'Thời tiết',
                        value: weather.description,
                        isDark: isDark,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String value,
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
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
                  size: 16,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: isDark ? Colors.grey[400] : Colors.grey[600],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : Colors.black87,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildMiniInfo({
    required IconData icon,
    required String label,
    required String value,
    required bool isDark,
  }) {
    return Column(
      children: [
        Icon(
          icon,
          color: isDark ? Colors.grey[400] : Colors.grey[600],
          size: 20,
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            color: isDark ? Colors.white : Colors.black87,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: isDark ? Colors.grey[400] : Colors.grey[600],
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
