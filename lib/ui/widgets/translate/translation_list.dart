import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/translate_cubit/translate_cubit.dart';

import 'package:sahayatri/ui/widgets/indicators/empty_indicator.dart';
import 'package:sahayatri/ui/widgets/translate/translate_bubble.dart';

class TranslationList extends StatelessWidget {
  const TranslationList();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TranslateCubit, TranslateState>(
      builder: (context, state) {
        if (state.translations.isEmpty) {
          return const EmptyIndicator(
            message: 'No translations yet...',
          );
        }

        final translations = state.translations.reversed.toList();
        return ListView.builder(
          reverse: true,
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.only(top: 16.0, bottom: 72.0),
          itemCount: translations.length,
          itemBuilder: (context, index) {
            return TranslateBubble(
              translation: translations[index],
            );
          },
        );
      },
    );
  }
}
