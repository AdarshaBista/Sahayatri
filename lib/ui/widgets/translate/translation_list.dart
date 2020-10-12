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

        final length = state.translations.length;
        final itemCount = state.isLoading ? length + 1 : length;

        return ListView.builder(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.only(top: 16.0, bottom: 72.0),
          itemCount: itemCount,
          itemBuilder: (context, index) {
            if (index == state.translations.length) return const CircularBusyIndicator();
            return TranslateBubble(
              isQuery: index.isEven,
              translation: state.translations[index],
            );
          },
        );
      },
    );
  }
}
