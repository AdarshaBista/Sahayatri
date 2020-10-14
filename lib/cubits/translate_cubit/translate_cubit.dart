import 'package:flutter/material.dart';

import 'package:meta/meta.dart';

import 'package:bloc/bloc.dart';

import 'package:sahayatri/core/models/language.dart';
import 'package:sahayatri/core/models/app_error.dart';
import 'package:sahayatri/core/models/translation.dart';

import 'package:sahayatri/core/services/tts_service.dart';
import 'package:sahayatri/core/services/translate_service.dart';

import 'package:sahayatri/app/constants/languages.dart';

part 'translate_state.dart';

class TranslateCubit extends Cubit<TranslateState> {
  final TtsService ttsService;
  final TranslateService translateService;

  final ScrollController controller = ScrollController();
  Language sourceLang = Languages.kDefaultSource;
  Language targetLang = Languages.kDefaultTarget;

  TranslateCubit({
    @required this.ttsService,
    @required this.translateService,
  })  : assert(ttsService != null),
        assert(translateService != null),
        super(TranslateState());

  Future<void> translate(String source) async {
    final query = Translation(isQuery: true, text: source, language: sourceLang);
    emit(TranslateState(
      isLoading: true,
      translations: [...state.translations, query],
    ));
    _scrollToEnd();

    Translation translation;
    try {
      final text = await translateService.translate(
        source,
        sourceLang.code,
        targetLang.code,
      );
      translation = Translation(text: text, language: targetLang);
    } on AppError catch (e) {
      translation = Translation(
        isError: true,
        text: e.message,
        language: Languages.kEnglish,
      );
    }
    emit(TranslateState(translations: [...state.translations, translation]));
    _scrollToEnd();
  }

  void flipLanguages() {
    final temp = sourceLang;
    sourceLang = targetLang;
    targetLang = temp;
  }

  Future<void> play(String text) async {
    await ttsService.play(text);
  }

  void _scrollToEnd() {
    if (controller.hasClients) {
      controller.animateTo(
        0.0,
        curve: Curves.decelerate,
        duration: const Duration(milliseconds: 300),
      );
    }
  }

  @override
  Future<void> close() {
    controller?.dispose();
    return super.close();
  }
}
