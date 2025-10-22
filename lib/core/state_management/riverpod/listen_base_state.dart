import 'package:flutter/material.dart';
import 'package:flutter_base_template/shared/widgets/toast/show_toast.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart';
import 'package:toastification/toastification.dart';

void listenAsyncValue<T>({
  required WidgetRef ref,
  required BuildContext context,
  required ProviderListenable<AsyncValue<T>> provider,
  String? successMessage,
  String? errorMessage,
  VoidCallback? onSuccess,
  void Function(T data)? onData,
  void Function(Object error)? onError,
}) {
  ref.listen<AsyncValue<T>>(provider, (previous, next) {
    next.whenOrNull(
      error: (error, _) {
        onError?.call(error);
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (context.mounted) {
            ShowToast(
              context,
              message: errorMessage ?? error.toString(),
              type: ToastificationType.error,
            );
          }
        });
      },
      data: (data) {
        onData?.call(data);
        if (context.mounted) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ShowToast(
              context,
              message: successMessage ?? "Thành công!",
              type: ToastificationType.success,
            );
          });
        }
        onSuccess?.call();
      },
    );
  });
}
