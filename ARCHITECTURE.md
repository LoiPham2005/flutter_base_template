# Kiến trúc dự án

Dự án này tuân theo nguyên tắc của **Clean Architecture** kết hợp với cấu trúc **Feature-First** để đảm bảo code được tổ chức một cách rõ ràng, dễ bảo trì và mở rộng.

## Các lớp chính trong Clean Architecture

Kiến trúc được chia thành 3 lớp chính:

1.  **Presentation Layer** (`lib/features/*/presentation`):
    -   **Chịu trách nhiệm:** Hiển thị UI và xử lý input từ người dùng.
    -   **Thành phần:** Widgets (Pages, UI Components), và State Management (BLoC, Cubit, Controller).
    -   **Luồng hoạt động:** Lớp này sẽ gọi các `UseCase` từ Domain Layer để thực thi business logic. Nó không được phép truy cập trực tiếp vào Data Layer.

2.  **Domain Layer** (`lib/features/*/domain`):
    -   **Chịu trách nhiệm:** Chứa business logic cốt lõi của ứng dụng. Đây là lớp trung tâm và không phụ thuộc vào bất kỳ lớp nào khác.
    -   **Thành phần:**
        -   **Entities:** Các đối tượng business thuần túy (ví dụ: `User`, `Product`).
        -   **Repositories (Abstract):** Các hợp đồng (interface) định nghĩa cách lấy dữ liệu, nhưng không quan tâm đến việc lấy từ đâu (API, database...).
        -   **UseCases (Interactors):** Đóng gói một quy trình nghiệp vụ cụ thể (ví dụ: `LoginUseCase`, `GetProductsUseCase`).

3.  **Data Layer** (`lib/features/*/data`):
    -   **Chịu trách nhiệm:** Cung cấp dữ liệu cho Domain Layer.
    -   **Thành phần:**
        -   **Repositories (Implementation):** Triển khai các interface từ Domain Layer. Lớp này quyết định lấy dữ liệu từ đâu (remote hay local).
        -   **Data Sources:** Các nguồn dữ liệu cụ thể (Remote: `DioClient` để gọi API; Local: `StorageService` để đọc từ `SharedPreferences`).
        -   **Models:** Các đối tượng dữ liệu (DTOs) có thể chứa logic để chuyển đổi từ JSON. Chúng thường kế thừa từ `Entities`.

## Luồng dữ liệu (Data Flow)

Một luồng hoạt động điển hình (ví dụ: lấy danh sách sản phẩm):

1.  **UI (Widget)** gọi một `Event` tới **BLoC**.
2.  **BLoC** gọi `execute()` của **`GetProductsUseCase`**.
3.  **`GetProductsUseCase`** gọi phương thức `getProducts()` trên **`ProductRepository`** (interface).
4.  **`ProductRepositoryImpl`** (trong Data Layer) nhận cuộc gọi. Nó kiểm tra kết nối mạng thông qua `NetworkInfo`.
5.  Nếu có mạng, **`ProductRepositoryImpl`** gọi **`ProductRemoteDataSource`**.
6.  **`ProductRemoteDataSource`** sử dụng **`DioClient`** để thực hiện cuộc gọi API.
7.  Dữ liệu JSON trả về được `ProductModel` phân tích.
8.  Dữ liệu được trả ngược về BLoC, BLoC phát ra một `State` mới.
9.  **UI** lắng nghe `State` và tự động cập nhật lại giao diện.

## Dependency Injection (DI)

-   **Công cụ:** `get_it` và `injectable`.
-   **Cơ chế:**
    -   Các class (Service, Repository, DataSource, BLoC...) được đánh dấu bằng các annotation như `@lazySingleton`, `@injectable`, `@factory`.
    -   Các dependency từ thư viện bên thứ ba (như `SharedPreferences`, `Connectivity`) được cung cấp thông qua một `@module` trong file `lib/core/di/injection.dart`.
    -   Chạy lệnh `flutter pub run build_runner build` sẽ tự động tạo ra file `injection.config.dart`, chứa toàn bộ logic để "tiêm" các dependency vào đúng nơi khi cần.
-   **Lợi ích:** Giảm sự phụ thuộc cứng, giúp code dễ dàng cho việc unit test và bảo trì.

## Quản lý trạng thái

Dự án được thiết kế để linh hoạt với nhiều giải pháp state management. Các lớp cơ sở đã được tạo sẵn trong `lib/core/state_management`:
-   **BLoC/Cubit:** Các file `BaseBloc`, `BaseState`...
-   **GetX:** `BaseController`.
-   **Riverpod:** Các thư mục ví dụ.

Bạn có thể chọn một hoặc kết hợp nhiều giải pháp tùy theo độ phức tạp của từng tính năng.