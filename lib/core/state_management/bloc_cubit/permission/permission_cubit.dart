// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../services/permission_service.dart';
// import '../base_state.dart';

// part 'permission_state.dart';

// class PermissionCubit extends BaseCubit<PermissionState> {
//   final PermissionService _permissionService;

//   PermissionCubit(this._permissionService)
//       : super(const PermissionState.initial());

//   Future<void> requestCamera() async {
//     safeEmit(const PermissionState.loading());
//     final granted = await _permissionService.requestCameraPermission();
//     safeEmit(PermissionState.result(
//       granted: granted,
//       message: granted ? 'Đã cấp quyền camera' : 'Từ chối quyền camera',
//     ));
//   }

//   Future<void> requestLocation() async {
//     safeEmit(const PermissionState.loading());
//     final granted = await _permissionService.requestLocationPermission();
//     safeEmit(PermissionState.result(
//       granted: granted,
//       message: granted ? 'Đã cấp quyền vị trí' : 'Từ chối quyền vị trí',
//     ));
//   }
// }
