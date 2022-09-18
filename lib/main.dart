import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:device_preview/device_preview.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'package:sahayatri/core/constants/configs.dart';
import 'package:sahayatri/core/models/models.dart';
import 'package:sahayatri/core/services/destinations_service.dart';
import 'package:sahayatri/core/utils/config_reader.dart';

import 'package:sahayatri/cubits/prefs_cubit/prefs_cubit.dart';
import 'package:sahayatri/cubits/theme_cubit/theme_cubit.dart';
import 'package:sahayatri/cubits/user_cubit/user_cubit.dart';

import 'package:sahayatri/locator.dart';
import 'package:sahayatri/sahayatri.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setSystemPreferences();

  await initHive();
  await ConfigReader.initialize();
  await registerGlobalServices();
  runApp(const App());
}

void setSystemPreferences() {
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp],
  );
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );
}

Future<void> initHive() async {
  final appDir = await getApplicationDocumentsDirectory();
  final hivePath = '${appDir.path}/${AppConfig.appName}';

  Hive.init(hivePath);

  Hive
    ..registerAdapter(UserAdapter())
    ..registerAdapter(PrefsAdapter())
    ..registerAdapter(CoordAdapter())
    ..registerAdapter(LodgeAdapter())
    ..registerAdapter(PlaceAdapter())
    ..registerAdapter(ReviewAdapter())
    ..registerAdapter(WeatherAdapter())
    ..registerAdapter(MapLayersAdapter())
    ..registerAdapter(ItineraryAdapter())
    ..registerAdapter(CheckpointAdapter())
    ..registerAdapter(DestinationAdapter())
    ..registerAdapter(TrackerDataAdapter())
    ..registerAdapter(ReviewDetailsAdapter())
    ..registerAdapter(LodgeFacilityAdapter());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return DevicePreview(
      enabled: Platform.isWindows,
      builder: (_) => MultiBlocProvider(
        child: const Sahayatri(),
        providers: [
          BlocProvider(create: (_) => ThemeCubit()),
          BlocProvider<PrefsCubit>(create: (_) => PrefsCubit()),
          BlocProvider<UserCubit>(
            create: (context) => UserCubit(
              onLogout: () => onLogout(context),
              onAuthenticated: (user) => onAuthenticated(context, user),
            ),
          ),
        ],
      ),
    );
  }

  void onAuthenticated(BuildContext context, User user) {
    getApplicationDocumentsDirectory().then((appDir) {
      final hivePath = '${appDir.path}/${AppConfig.appName}';
      final userDirectoryPath = '$hivePath/${user.id}';
      Directory(userDirectoryPath).createSync();
    });

    registerUserDependentServices(user.id).then((_) {
      final prefsCubit = BlocProvider.of<PrefsCubit>(context);
      prefsCubit.init().then((_) {
        final prefs = prefsCubit.prefs;
        BlocProvider.of<ThemeCubit>(context).init(prefs.theme);
      });
    });
  }

  void onLogout(BuildContext context) {
    unregisterUserDependentServices().then((_) {
      locator<DestinationsService>().clearDownloaded();

      context.read<PrefsCubit>().reset();
      context.read<ThemeCubit>().changeTheme(ThemeMode.system);
    });
  }
}
