import 'package:translator/translator.dart';

import 'package:sahayatri/core/models/app_error.dart';

class TranslateService {
  final GoogleTranslator translator = GoogleTranslator();

  Future<String> translate(String source, String from, String to) async {
    try {
      final translation = await translator.translate(
        source,
        from: from,
        to: to,
      );
      return translation.text;
    } catch (e) {
      print(e.toString());
      throw const AppError(message: 'An error has occured!');
    }
  }
}
