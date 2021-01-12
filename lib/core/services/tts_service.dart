import 'dart:io';

import 'package:flutter_tts/flutter_tts.dart';

class TtsService {
  final FlutterTts tts = FlutterTts();

  /// Last spoken language.
  String _currentLang = '';

  Future<void> play(String text, String language) async {
    if (Platform.isWindows) return;

    if (language.isEmpty) return;
    if (language == _currentLang) {
      _speak(text);
      return;
    }

    final canPlay = await tts.isLanguageAvailable(language) as bool;
    if (canPlay) {
      _currentLang = language;
      _speak(text);
    }
  }

  Future<void> _speak(String text) async {
    await tts.stop();
    await tts.setLanguage(_currentLang);
    tts.speak(text);
  }
}
