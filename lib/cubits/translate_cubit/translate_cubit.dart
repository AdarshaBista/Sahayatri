import 'package:meta/meta.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:sahayatri/core/models/app_error.dart';
import 'package:sahayatri/core/models/translation.dart';

import 'package:sahayatri/core/services/translate_service.dart';

part 'translate_state.dart';

class TranslateCubit extends Cubit<TranslateState> {
  final TranslateService translateService;

  TranslateCubit({
    @required this.translateService,
  })  : assert(translateService != null),
        super(const TranslateEmpty());

  Future<void> translate(String source) async {
    emit(const TranslateLoading());
    try {
      final translation = await translateService.translate(source);
      emit(TranslateSuccess(translation: translation));
    } on AppError catch (e) {
      emit(TranslateError(message: e.message));
    }
  }
}
