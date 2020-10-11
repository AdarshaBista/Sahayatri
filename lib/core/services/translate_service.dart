import 'package:translator/translator.dart' as t;

import 'package:sahayatri/core/models/app_error.dart';
import 'package:sahayatri/core/models/translation.dart';

class TranslateService {
  final t.GoogleTranslator translator = t.GoogleTranslator();

  Future<Translation> translate(String source) async {
    try {
      final translation = await translator.translate(source, to: 'ne');
      return Translation(
        text: translation.text,
        source: translation.source,
        sourceLang: translation.sourceLanguage.name,
        targetLang: translation.targetLanguage.name,
      );
    } catch (e) {
      print(e.toString());
      throw const AppError(message: 'Could not perform transation!');
    }
  }
}
