import 'package:injectable/injectable.dart';
import '../errors/exceptions.dart';
import '../errors/failures.dart';
import '../errors/result.dart';
import 'network_info.dart';

/// ✅ BaseRepository: chứa hàm dùng chung cho tất cả Repository
@lazySingleton
class BaseRepository {
  final NetworkInfo networkInfo;

  BaseRepository(this.networkInfo);

  /// Hàm xử lý logic gọi API an toàn cho mọi repository
  /// - Kiểm tra mạng
  /// - Bắt lỗi ServerException, UnknownFailure
  /// - Trả về Result<T>
   /// ✅ Hàm xử lý cho remoteCall trả về Result<T>
  Future<Result<T>> safeCall<T>(
    Future<Result<T>> Function() remoteCall,
  ) async {
    // 1️⃣ Kiểm tra kết nối mạng
    if (!await networkInfo.isConnected) {
      return const Error(NetworkFailure());
    }

    // 2️⃣ Trả về Result từ remoteCall (đã được xử lý ở ApiClient)
    return await remoteCall();
  }
}
