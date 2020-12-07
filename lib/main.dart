import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'package:sahayatri/core/models/user.dart';
import 'package:sahayatri/core/models/prefs.dart';
import 'package:sahayatri/core/models/coord.dart';
import 'package:sahayatri/core/models/lodge.dart';
import 'package:sahayatri/core/models/place.dart';
import 'package:sahayatri/core/models/review.dart';
import 'package:sahayatri/core/models/weather.dart';
import 'package:sahayatri/core/models/itinerary.dart';
import 'package:sahayatri/core/models/map_layers.dart';
import 'package:sahayatri/core/models/checkpoint.dart';
import 'package:sahayatri/core/models/destination.dart';
import 'package:sahayatri/core/models/tracker_data.dart';
import 'package:sahayatri/core/models/review_details.dart';
import 'package:sahayatri/core/models/lodge_facility.dart';

import 'package:sahayatri/core/services/api_service.dart';
import 'package:sahayatri/core/services/tts_service.dart';
import 'package:sahayatri/core/services/auth_service.dart';
import 'package:sahayatri/core/services/location_service.dart';
import 'package:sahayatri/core/services/translate_service.dart';
import 'package:sahayatri/core/services/navigation_service.dart';
import 'package:sahayatri/core/services/notification_service.dart';

import 'package:sahayatri/app/database/user_dao.dart';
import 'package:sahayatri/app/database/prefs_dao.dart';
import 'package:sahayatri/app/database/tracker_dao.dart';
import 'package:sahayatri/app/database/weather_dao.dart';
import 'package:sahayatri/app/database/itinerary_dao.dart';
import 'package:sahayatri/app/database/destination_dao.dart';

import 'package:sahayatri/app/constants/configs.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sahayatri/sahayatri.dart';

import 'package:device_preview/plugins.dart';
import 'package:device_preview/device_preview.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  setSystemPreferences();
  await initHive();
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

  Hive
    ..init(hivePath)
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
  const App();

  @override
  Widget build(BuildContext context) {
    return DevicePreview(
      enabled: Platform.isWindows,
      storage: FileDevicePreviewStorage(file: File('./temp/device_preview.json')),
      plugins: [
        ScreenshotPlugin(
          processor: (ss) async {
            final dir = await getDownloadsDirectory();
            final fileName = DateTime.now().microsecondsSinceEpoch;
            final savePath = '${dir.path}/$fileName.png';
            await File(savePath).writeAsBytes(ss.bytes);

            print('Saved image as $savePath');
            return savePath;
          },
        ),
      ],
      builder: (_) => MultiRepositoryProvider(
        providers: [
          RepositoryProvider(create: (_) => UserDao()),
          RepositoryProvider(create: (_) => PrefsDao()),
          RepositoryProvider(create: (_) => TrackerDao()),
          RepositoryProvider(create: (_) => WeatherDao()),
          RepositoryProvider(create: (_) => TtsService()),
          RepositoryProvider(create: (_) => ApiService()),
          RepositoryProvider(create: (_) => AuthService()),
          RepositoryProvider(create: (_) => ItineraryDao()),
          RepositoryProvider(create: (_) => RootNavService()),
          RepositoryProvider(create: (_) => DestinationDao()),
          RepositoryProvider(create: (_) => LocationService()),
          RepositoryProvider(create: (_) => TranslateService()),
          RepositoryProvider(create: (_) => NotificationService()),
          RepositoryProvider(create: (_) => DestinationNavService()),
        ],
        child: const Sahayatri(),
      ),
    );
  }
}
