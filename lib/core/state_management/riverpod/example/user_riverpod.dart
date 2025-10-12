// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:dat_san_247_mobile/features/authentication2/domain/usecases/get_users_usecase.dart';
// import 'user_notifier.dart';
// import 'user_state.dart';

// /// Provider cho UserNotifier
// final userNotifierProvider =
//     StateNotifierProvider<UserNotifier, UserState>((ref) {
//   final getUsersUseCase = ref.watch(getUsersUseCaseProvider);
//   return UserNotifier(getUsersUseCase);
// });

// /// Provider cho GetUsersUseCase
// final getUsersUseCaseProvider = Provider<GetUsersUseCase>((ref) {
//   throw UnimplementedError('Cần inject UserRepository vào đây!');
// });
