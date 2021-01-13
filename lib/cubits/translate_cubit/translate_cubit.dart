import 'package:flutter/material.dart';

import 'package:bloc/bloc.dart';

import 'package:sahayatri/locator.dart';

import 'package:sahayatri/core/models/language.dart';
import 'package:sahayatri/core/models/app_error.dart';
import 'package:sahayatri/core/models/translation.dart';

import 'package:sahayatri/core/services/tts_service.dart';
import 'package:sahayatri/core/services/translate_service.dart';

import 'package:sahayatri/core/constants/languages.dart';

part 'translate_state.dart';

class TranslateCubit extends Cubit<TranslateState> {
  final TtsService ttsService = locator();
  final TranslateService translateService = locator();

  final ScrollController controller = ScrollController();
  Language sourceLang = Languages.defaultSource;
  Language targetLang = Languages.defaultTarget;

  TranslateCubit() : super(TranslateState());

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
        language: Languages.english,
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

  Future<void> play(String text, String language) async {
    await ttsService.play(text, language);
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
