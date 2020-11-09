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
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(32.0),
              child: EmptyIndicator(
                message: 'No translations yet...',
              ),
            ),
          );
        }

        final translations = state.translations.reversed.toList();
        return ListView.builder(
          controller: context.watch<TranslateCubit>().controller,
          reverse: true,
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.only(top: 50.0, bottom: 80.0),
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
