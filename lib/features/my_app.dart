import 'package:flutter/material.dart';
import 'package:flutter_base_template/core/constants/app_constants.dart';
import 'package:flutter_base_template/core/di/injection.dart';
import 'package:flutter_base_template/core/l10n/localization_service.dart';
import 'package:flutter_base_template/core/theme/app_theme.dart';
import 'package:flutter_base_template/core/theme/theme_cubit.dart';
import 'package:flutter_base_template/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter_base_template/gen/l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/routes/app_routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final localeCubit = getIt<LocaleCubit>();
    final themeCubit = getIt<ThemeCubit>();
    final appRoutes = getIt<AppRoutes>();

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => localeCubit..initLocale()),
        BlocProvider(create: (_) => themeCubit..initTheme()),
        BlocProvider(create: (_) => getIt<AuthBloc>()),
      ],
      // ✅ THAY VÌ lồng BlocBuilder, dùng Builder + context.select()
      child: Builder(
        builder: (context) {
          // ✅ Lấy locale từ LocaleCubit
          final locale = context.select((LocaleCubit cubit) => cubit.state);

          // ✅ Lấy themeState từ ThemeCubit
          final themeState = context.select((ThemeCubit cubit) => cubit.state);

          return MaterialApp.router(
            title: AppConstants.appName,
            debugShowCheckedModeBanner: false,

            // Theme
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeState.themeMode,

            // Localization
            locale: locale,
            supportedLocales: AppLocalizations.supportedLocales,
            localizationsDelegates: AppLocalizations.localizationsDelegates,

            // Navigation
            // navigatorKey: NavigationService().navigatorKey,

            // home: const SplashPage(),

            routerConfig: appRoutes.router,

          );
        },
      ),
    );
  }
}
