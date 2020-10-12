import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/translate_cubit/translate_cubit.dart';

import 'package:sahayatri/ui/widgets/indicators/empty_indicator.dart';
import 'package:sahayatri/ui/widgets/translate/translate_bubble.dart';
import 'package:sahayatri/ui/widgets/indicators/circular_busy_indicator.dart';

class TranslationList extends StatelessWidget {
  const TranslationList();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TranslateCubit, TranslateState>(
      builder: (context, state) {
        if (state.translations.isEmpty) return const EmptyIndicator();

        return ListView.builder(
          padding: const EdgeInsets.only(top: 16.0, bottom: 72.0),
          physics: const BouncingScrollPhysics(),
          itemCount: state.translations.length,
          itemBuilder: (context, index) {
            final t = state.translations[index];

            return Column(
              children: [
                TranslateBubble(
                  isSelf: true,
                  text: t.source,
                  language: t.sourceLang,
                ),
                state.isLoading
                    ? const CircularBusyIndicator()
                    : TranslateBubble(
                        isSelf: false,
                        text: t.result,
                        language: t.resultLang,
                      ),
              ],
            );
          },
        );
      },
    );
  }
}
