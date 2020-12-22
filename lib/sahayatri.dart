import 'dart:io';

import 'package:flutter/material.dart';

import 'package:path_provider/path_provider.dart';

import 'package:sahayatri/locator.dart';

import 'package:sahayatri/core/models/user.dart';
import 'package:sahayatri/core/services/navigation_service.dart';

import 'package:sahayatri/app/constants/configs.dart';
import 'package:sahayatri/app/routers/root_router.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/user_cubit/user_cubit.dart';
import 'package:sahayatri/cubits/prefs_cubit/prefs_cubit.dart';
import 'package:sahayatri/cubits/theme_cubit/theme_cubit.dart';
import 'package:sahayatri/cubits/nearby_cubit/nearby_cubit.dart';
import 'package:sahayatri/cubits/translate_cubit/translate_cubit.dart';

import 'package:device_preview/device_preview.dart';
import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/common/splash_view.dart';

import 'package:sahayatri/ui/pages/auth_page/auth_page.dart';
import 'package:sahayatri/ui/pages/home_page/home_page.dart';

class Sahayatri extends StatelessWidget {
  const Sahayatri();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ThemeCubit()),
        BlocProvider<PrefsCubit>(create: (context) => PrefsCubit()),
        BlocProvider<NearbyCubit>(create: (context) => NearbyCubit()),
        BlocProvider<TranslateCubit>(create: (context) => TranslateCubit()),
        BlocProvider<UserCubit>(
          create: (context) => UserCubit(
            onAuthenticated: (user) => onAuthenticated(context, user),
          ),
        ),
      ],
      child: _buildApp(),
    );
  }

  Widget _buildApp() {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, themeMode) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: themeMode,
          theme: AppThemes.light,
          darkTheme: AppThemes.dark,
          title: AppConfig.appName,
          builder: DevicePreview.appBuilder,
          locale: DevicePreview.locale(context),
          onGenerateRoute: RootRouter.onGenerateRoute,
          navigatorKey: locator<RootNavService>().navigatorKey,
          home: _buildUserState(context),
        );
      },
    );
  }

  Widget _buildUserState(BuildContext context) {
    return FutureBuilder<bool>(
      initialData: false,
      future: BlocProvider.of<UserCubit>(context).isLoggedIn(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final isLoggedIn = snapshot.data;
          if (isLoggedIn) return _buildPrefsState(context);
          return const AuthPage();
        }
        return const SplashView();
      },
    );
  }

  Widget _buildPrefsState(BuildContext context) {
    return BlocBuilder<PrefsCubit, PrefsState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const SplashView();
        }
        return const HomePage();
      },
    );
  }

  void onAuthenticated(BuildContext context, User user) {
    getApplicationDocumentsDirectory().then((appDir) {
      final hivePath = '${appDir.path}/${AppConfig.appName}';
      final userDirectoryPath = '$hivePath/${user.id}';
      Directory(userDirectoryPath).createSync();
    });

    setupUserDependentDaos(user.id);
    final prefsCubit = BlocProvider.of<PrefsCubit>(context);
    prefsCubit.init().then((_) {
      final prefs = prefsCubit.prefs;
      BlocProvider.of<ThemeCubit>(context).init(prefs.theme);
    });
  }
}
