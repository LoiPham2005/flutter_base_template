# Flutter Production-Ready Template

Một template dự án Flutter hoàn chỉnh, sẵn sàng cho production với kiến trúc sạch, các gói thư viện thiết yếu và các thực hành tốt nhất đã được tích hợp.

## 🚀 Tính năng nổi bật

- 🏗️ **Kiến trúc sạch (Clean Architecture)**: Phân tách rõ ràng các lớp Presentation, Domain, và Data.
- 📁 **Cấu trúc theo tính năng (Feature-First)**: Dễ dàng tìm kiếm, quản lý và phát triển các tính năng độc lập.
- 🔄 **Quản lý trạng thái đa dạng**: Hỗ trợ sẵn **BLoC**, **GetX**, và **Riverpod**.
- 💉 **Dependency Injection**: Tích hợp `get_it` và `injectable` để quản lý dependency một cách tự động và hiệu quả.
- 🌐 **Lớp mạng (Networking)**: Sử dụng `Dio` mạnh mẽ với các `Interceptor` (Auth, Logging, Error) đã được cấu hình.
- 🔒 **Lưu trữ an toàn**: Tích hợp `shared_preferences` cho dữ liệu thông thường và `flutter_secure_storage` cho dữ liệu nhạy cảm.
- 🎨 **Quản lý Theme**: Dễ dàng chuyển đổi giữa Light/Dark mode và lưu trạng thái.
- 🌍 **Đa ngôn ngữ (Localization)**: Cấu hình sẵn cho việc dịch thuật với file `.arb`.
- 📱 **Giao diện đáp ứng (Responsive UI)**: Các tiện ích và hằng số cho việc xây dựng UI linh hoạt.
- 🧪 **Cấu hình Test**: Nền tảng cho Unit, Widget, và Integration Test.
- ⚙️ **Tự động hóa**: Tích hợp sẵn GitHub Actions cho CI (Continuous Integration).

## 📂 Cấu trúc thư mục

```
lib/
├── core/                   # Chức năng cốt lõi, dùng chung toàn ứng dụng
│   ├── config/             # Cấu hình khởi tạo app (Observer, Initializer)
│   ├── constants/          # Các hằng số (API endpoints, App info)
│   ├── di/                 # Dependency Injection (get_it, injectable)
│   ├── errors/             # Xử lý lỗi (Failures, Exceptions)
│   ├── extensions/         # Các hàm mở rộng tiện ích
│   ├── l10n/               # Đa ngôn ngữ (Localization)
│   ├── network/            # Lớp mạng (Dio, Interceptors, API Client)
│   ├── services/           # Các dịch vụ nền (Notifications, Dialogs)
│   ├── state_management/   # Các lớp cơ sở cho BLoC, GetX, Riverpod
│   ├── storage/            # Lưu trữ dữ liệu (SharedPreferences, Secure Storage)
│   ├── theme/              # Quản lý giao diện (Colors, Styles, Themes)
│   └── utils/              # Các hàm tiện ích (Logger, Validators)
│
├── features/               # Các tính năng của ứng dụng
│   ├── auth/               # Ví dụ: Tính năng xác thực
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   └── ...                 # Các tính năng khác
│
└── shared/                 # Các thành phần dùng chung trong UI
    ├── models/             # Các model chung
    └── widgets/            # Các widget có thể tái sử dụng
```

## 🛠️ Bắt đầu

### Yêu cầu
- Flutter SDK (phiên bản 3.22.0 trở lên)
- Dart SDK (phiên bản 3.4.0 trở lên)
- Android Studio / VS Code

### Cài đặt
1.  **Clone repository:**
    ```bash
    git clone <your-repository-url>
    cd <your-project-name>
    ```

2.  **Cài đặt các gói thư viện:**
    ```bash
    flutter pub get
    ```

3.  **Tạo các file cần thiết (code generation):**
    Lệnh này sẽ tạo ra các file `.g.dart`, `.freezed.dart` và `injection.config.dart`.
    ```bash
    flutter pub run build_runner build --delete-conflicting-outputs
    ```

### Chạy ứng dụng
Dự án đã được cấu hình sẵn trong file `.vscode/launch.json` để chạy với các môi trường khác nhau.

-   Mở VS Code, vào tab "Run and Debug" (Ctrl+Shift+D).
-   Chọn một trong các cấu hình sau từ dropdown:
    -   `🧩 Development`
    -   `🧪 Staging`
    -   `🚀 Production`
-   Nhấn F5 để bắt đầu.

## 📱 Build ứng dụng

### Android
1.  **Tạo Keystore:**
    Nếu chưa có, hãy tạo một file keystore để ký ứng dụng.
    ```bash
    keytool -genkey -v -keystore android/app/signing/release-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload
    ```

2.  **Cập nhật `android/key.properties`:**
    Điền thông tin keystore của bạn vào file này.
    ```properties
    storePassword=your_store_password
    keyPassword=your_key_password
    keyAlias=upload
    storeFile=signing/release-keystore.jks
    ```

3.  **Build APK hoặc App Bundle:**
    ```bash
    # Build APK
    flutter build apk --release

    # Build App Bundle
    flutter build appbundle --release
    ```

### iOS
1.  Mở dự án `ios/Runner.xcworkspace` bằng Xcode.
2.  Trong Xcode, chọn `Product` > `Archive`.
3.  Làm theo các bước để ký và phân phối ứng dụng.

## 📚 Hướng dẫn sử dụng các Core Services

### ThemeService
Quản lý và thay đổi giao diện sáng/tối.
```dart
// Lấy service từ DI
final themeService = getIt<ThemeService>();

// Chuyển đổi theme
themeService.toggleTheme();

// Kiểm tra theme hiện tại
if (themeService.isDarkMode) {
  // ...
}
```

### LocalizationService
Quản lý và thay đổi ngôn ngữ.
```dart
// Lấy service từ DI
final localizationService = getIt<LocalizationService>();

// Thay đổi ngôn ngữ sang tiếng Anh
localizationService.changeLocale('en');
```
Sử dụng trong widget:
```dart
import 'package:flutter_base_template/core/extensions/localization_x.dart';

Text(context.tr.hello); // "hello" là key trong file .arb
```

### StorageService
Lưu trữ dữ liệu không nhạy cảm.
```dart
final storageService = getIt<StorageService>();

// Lưu dữ liệu
await storageService.set('my_key', 'my_value');

// Đọc dữ liệu
String? myValue = storageService.get<String>('my_key');
```

### SecureStorage
Lưu trữ dữ liệu nhạy cảm (ví dụ: token).
```dart
final secureStorage = getIt<SecureStorage>();

// Lưu token
await secureStorage.write(key: StorageKeys.accessToken, value: 'your_secret_token');

// Đọc token
String? token = await secureStorage.read(key: StorageKeys.accessToken);
```