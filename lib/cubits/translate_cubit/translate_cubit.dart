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

  Future<void> translate(String source) async {
    emit(state.copyWith(isLoading: true));
    try {
      final translation = await translateService.translate(source);
      final newTranslations = [...state.translations, translation];
      emit(state.copyWith(
        translations: newTranslations,
        isLoading: false,
      ));
    } on AppError catch (e) {
      state.translations.add(
        Translation(
          source: source,
          result: e.message,
          sourceLang: 'Nepali',
          resultLang: 'English',
        ),
      );
      emit(state.copyWith(isLoading: false));
    }
  }
}
