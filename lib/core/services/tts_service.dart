import 'dart:io';

import 'package:flutter_tts/flutter_tts.dart';

class TtsService {
  final FlutterTts tts = FlutterTts();

  /// Default language for TTS.
  final String _defaultLanguage = 'ne-NP';

  /// Audio cannot be played if language is not available.
  bool _canPlay = false;

  TtsService() {
    _setLang();
  }

  Future<void> _setLang() async {
    if (Platform.isWindows) return;
    _canPlay = await tts.isLanguageAvailable(_defaultLanguage) as bool;
    if (_canPlay) tts.setLanguage(_defaultLanguage);
  }

  Future<void> play(String text) async {
    if (Platform.isWindows) return;
    tts.stop();
    if (_canPlay) tts.speak(text);
  }
}
