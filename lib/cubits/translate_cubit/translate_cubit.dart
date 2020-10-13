import 'package:flutter/material.dart';

import 'package:meta/meta.dart';

import 'package:bloc/bloc.dart';

import 'package:sahayatri/core/models/app_error.dart';
import 'package:sahayatri/core/models/translation.dart';

import 'package:sahayatri/core/services/tts_service.dart';
import 'package:sahayatri/core/services/translate_service.dart';

part 'translate_state.dart';

class TranslateCubit extends Cubit<TranslateState> {
  final TtsService ttsService;
  final TranslateService translateService;
  final ScrollController controller = ScrollController();

  TranslateCubit({
    @required this.ttsService,
    @required this.translateService,
  })  : assert(ttsService != null),
        assert(translateService != null),
        super(TranslateState());

  Future<void> translate(String source, String language) async {
    final query = Translation(isQuery: true, text: source, language: language);
    emit(TranslateState(
      isLoading: true,
      translations: [...state.translations, query],
    ));
    scrollToEnd();

    Translation translation;
    try {
      translation = await translateService.translate(source);
    } on AppError catch (e) {
      translation = Translation(isQuery: false, text: e.message);
    }
    emit(TranslateState(translations: [...state.translations, translation]));
    scrollToEnd();
  }

  Future<void> play(String text) async {
    await ttsService.play(text);
  }

  void scrollToEnd() {
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
