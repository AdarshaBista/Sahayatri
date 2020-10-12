import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/translate_cubit/translate_cubit.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/common/elevated_card.dart';

class TranslateBubble extends StatelessWidget {
  final bool isSelf;
  final String text;
  final String language;

  const TranslateBubble({
    @required this.text,
    @required this.isSelf,
    @required this.language,
  })  : assert(text != null),
        assert(isSelf != null),
        assert(language != null);

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.only(
      topLeft: Radius.circular(isSelf ? 12.0 : 0.0),
      topRight: Radius.circular(isSelf ? 0.0 : 12.0),
      bottomLeft: Radius.circular(isSelf ? 12.0 : 0.0),
      bottomRight: Radius.circular(isSelf ? 0.0 : 12.0),
    );

    return Align(
      alignment: isSelf ? Alignment.centerRight : Alignment.centerLeft,
      child: ElevatedCard(
        borderRadius: borderRadius,
        color: isSelf ? AppColors.primaryDark : AppColors.light,
        margin: EdgeInsets.only(
          top: 8.0,
          bottom: 8.0,
          left: isSelf ? 50.0 : 0.0,
          right: isSelf ? 0.0 : 50.0,
        ),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: BlocBuilder<TranslateCubit, TranslateState>(
            builder: (context, state) {
              return _buildText();
            },
          ),
        ),
      ),
    );
  }

  Widget _buildText() {
    return Column(
      crossAxisAlignment: isSelf ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Text(
          language,
          style: isSelf
              ? AppTextStyles.extraSmall.lightAccent
              : AppTextStyles.extraSmall.darkAccent,
        ),
        const SizedBox(height: 4.0),
        Text(
          text,
          style: isSelf ? AppTextStyles.small.light : AppTextStyles.small.dark,
        ),
      ],
    );
  }
}
