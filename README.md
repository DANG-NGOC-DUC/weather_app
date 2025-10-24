# Weather App 🌤️

Ứng dụng thời tiết được xây dựng bằng Flutter với kiến trúc Clean Architecture.

## Tính năng

- ✅ Xem thời tiết theo thành phố
- ✅ Giao diện đẹp mắt với gradient
- ✅ Hiển thị icon thời tiết từ OpenWeatherMap
- ✅ Thông tin chi tiết về thời tiết
- ✅ Xử lý lỗi và loading state
- ✅ Kiến trúc Clean Architecture với BLoC pattern

## Cài đặt

### 1. Cài đặt Flutter
Đảm bảo bạn đã cài đặt Flutter SDK. Xem hướng dẫn tại: https://flutter.dev/docs/get-started/install

### 2. Clone project
```bash
git clone <repository-url>
cd weather_app
```

### 3. Cài đặt dependencies
```bash
flutter pub get
```

### 4. Cấu hình API Key
1. Đăng ký tài khoản miễn phí tại: https://openweathermap.org/api
2. Lấy API key từ dashboard
3. Mở file `lib/core/constants/api_constants.dart`
4. Thay thế `YOUR_API_KEY` bằng API key thật của bạn

```dart
static const String apiKey = 'your_actual_api_key_here';
```

### 5. Chạy ứng dụng
```bash
flutter run
```

## Cấu trúc project

```
lib/
├── core/                    # Core utilities và constants
│   ├── constants/          # API constants và app colors
│   └── utils/              # Date formatter và location helper
├── data/                   # Data layer
│   ├── models/            # Weather model
│   ├── repositories/      # Weather repository
│   └── services/          # API service và location service
├── presentation/          # Presentation layer
│   ├── screens/          # Home screen
│   ├── widgets/          # Weather card và weather details
│   └── theme/            # App theme
├── state/                # State management với BLoC
│   └── weather_cubit.dart
└── main.dart             # Entry point
```

## Kiến trúc

Ứng dụng sử dụng Clean Architecture với các layer:

- **Presentation Layer**: UI components, screens, widgets
- **Domain Layer**: Business logic (thông qua BLoC)
- **Data Layer**: API services, repositories, models

## Sử dụng

1. Mở ứng dụng
2. Nhập tên thành phố vào ô tìm kiếm
3. Nhấn Enter hoặc icon tìm kiếm
4. Xem thông tin thời tiết hiển thị

## API sử dụng

- **OpenWeatherMap API**: https://openweathermap.org/api
- **Endpoint**: Current Weather Data
- **Format**: JSON
- **Units**: Metric (Celsius)

## Dependencies chính

- `flutter_bloc`: State management
- `http`: API calls
- `intl`: Date formatting

## Lưu ý

- Cần có kết nối internet để sử dụng
- API key miễn phí có giới hạn 1000 calls/day
- Tên thành phố có thể nhập bằng tiếng Anh hoặc tiếng Việt

## Phát triển thêm

Có thể mở rộng ứng dụng với các tính năng:
- Dự báo thời tiết 5 ngày
- Lưu danh sách thành phố yêu thích
- Thông báo thời tiết
- Widget cho home screen
- Dark mode
- Đa ngôn ngữ
