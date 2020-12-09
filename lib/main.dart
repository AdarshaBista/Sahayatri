import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'package:sahayatri/core/models/models.dart';
import 'package:sahayatri/app/constants/configs.dart';

import 'package:sahayatri/locator.dart';
import 'package:sahayatri/sahayatri.dart';

import 'package:device_preview/plugins.dart';
import 'package:device_preview/device_preview.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setSystemPreferences();

  await initHive();
  setupLocator();
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
      isToolbarVisible: false,
      enabled: Platform.isWindows,
      plugins: [ScreenshotPlugin(processor: _saveScreenshot)],
      storage: FileDevicePreviewStorage(file: File('./temp/device_preview.json')),
      builder: (_) => const Sahayatri(),
    );
  }

  Future<String> _saveScreenshot(DeviceScreenshot ss) async {
    final dir = await getDownloadsDirectory();
    final fileName = DateTime.now().microsecondsSinceEpoch;
    final savePath = '${dir.path}/$fileName.png';
    await File(savePath).writeAsBytes(ss.bytes);
    return savePath;
  }
}
