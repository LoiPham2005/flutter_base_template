// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:dat_san_247_mobile/features/authentication2/domain/usecases/get_users_usecase.dart';
// import 'user_state.dart';

// class UserNotifier extends StateNotifier<UserState> {
//   final GetUsersUseCase getUsersUseCase;

//   UserNotifier(this.getUsersUseCase) : super(UserState.initial());

//   /// Hàm fetch toàn bộ danh sách user
//   Future<void> fetchUsers() async {
//     state = state.copyWith(isLoading: true, error: null);
//     try {
//       final result = await getUsersUseCase();
//       state = state.copyWith(isLoading: false, users: result.data ?? []);
//     } catch (e) {
//       state = state.copyWith(isLoading: false, error: e.toString());
//     }
//   }
// }
