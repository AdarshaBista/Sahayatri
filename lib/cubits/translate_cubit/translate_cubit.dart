import 'package:meta/meta.dart';

import 'package:bloc/bloc.dart';

import 'package:sahayatri/core/models/app_error.dart';
import 'package:sahayatri/core/models/translation.dart';

import 'package:sahayatri/core/services/translate_service.dart';

part 'translate_state.dart';

class TranslateCubit extends Cubit<TranslateState> {
  final TranslateService translateService;

  TranslateCubit({
    @required this.translateService,
  })  : assert(translateService != null),
        super(TranslateState());

  Future<void> translate(String source, String language) async {
    if (source == 'cls') {
      emit(TranslateState(translations: []));
      return;
    }

    final query = Translation(isQuery: true, text: source, language: language);
    emit(TranslateState(
      isLoading: true,
      translations: [...state.translations, query],
    ));

    Translation translation;
    try {
      translation = await translateService.translate(source);
    } on AppError catch (e) {
      translation = Translation(isQuery: false, text: e.message);
    }
    emit(TranslateState(translations: [...state.translations, translation]));
  }
}
