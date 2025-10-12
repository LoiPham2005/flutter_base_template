part of 'permission_cubit.dart';

class PermissionState {
  final bool? granted;
  final String? message;
  final bool isLoading;

  const PermissionState({
    this.granted,
    this.message,
    this.isLoading = false,
  });

  const PermissionState.initial()
      : granted = null,
        message = null,
        isLoading = false;

  const PermissionState.loading()
      : granted = null,
        message = null,
        isLoading = true;

  const PermissionState.result({required bool granted, String? message})
      : granted = granted,
        message = message,
        isLoading = false;
}
