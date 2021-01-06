import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/translation.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/translate_cubit/translate_cubit.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/common/icon_label.dart';

class TranslateBubble extends StatelessWidget {
  final Translation translation;

  const TranslateBubble({
    @required this.translation,
  }) : assert(translation != null);

  @override
  Widget build(BuildContext context) {
    final isQuery = translation.isQuery;

    return Container(
      alignment: isQuery ? Alignment.centerRight : Alignment.centerLeft,
      margin: EdgeInsets.only(
        top: 2.0,
        bottom: 2.0,
        left: isQuery ? 50.0 : 0.0,
        right: isQuery ? 0.0 : 50.0,
      ),
      child: Column(
        crossAxisAlignment: isQuery ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          _buildAudioButton(context),
          _buildText(context),
        ],
      ),
    );
  }

  Widget _buildText(BuildContext context) {
    const double radius = 20.0;
    final isQuery = translation.isQuery;
    final isError = translation.isError;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: isQuery ? AppColors.primaryDark : context.c.surface,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(isQuery ? radius : 0.0),
          topRight: Radius.circular(isQuery ? 0.0 : radius),
          bottomLeft: Radius.circular(isQuery ? radius : 0.0),
          bottomRight: Radius.circular(isQuery ? 0.0 : radius),
        ),
      ),
      child: Text(
        translation.text,
        style: isQuery
            ? AppTextStyles.headline5.light
            : isError
                ? AppTextStyles.headline5.secondary
                : context.t.headline5,
      ),
    );
  }

  Widget _buildAudioButton(BuildContext context) {
    return GestureDetector(
      onTap: () => context.read<TranslateCubit>().play(translation.text),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: IconLabel(
          iconSize: 16.0,
          icon: Icons.volume_up_rounded,
          iconColor: context.c.onSurface,
          labelStyle: context.t.headline6,
          label: translation.language.title,
        ),
      ),
    );
  }
}
