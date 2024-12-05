import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sahayatri/core/constants/configs.dart';

import 'package:sahayatri/cubits/translate_cubit/translate_cubit.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/animators/slide_animator.dart';
import 'package:sahayatri/ui/widgets/common/elevated_card.dart';
import 'package:sahayatri/ui/widgets/indicators/circular_busy_indicator.dart';

class TranslateTextField extends StatefulWidget {
  final bool resizeToAvoidBottomInset;

  const TranslateTextField({
    super.key,
    required this.resizeToAvoidBottomInset,
  });

  @override
  State<TranslateTextField> createState() => _TranslateTextFieldState();
}

class _TranslateTextFieldState extends State<TranslateTextField> {
  TextEditingController sourceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (!widget.resizeToAvoidBottomInset) return _buildCard();

    return AnimatedPadding(
      curve: Curves.decelerate,
      padding: MediaQuery.of(context).viewInsets,
      duration: const Duration(milliseconds: 100),
      child: _buildCard(),
    );
  }

  Widget _buildCard() {
    return SlideAnimator(
      begin: const Offset(0.0, 2.0),
      child: ElevatedCard(
        color: context.theme.cardColor,
        margin: const EdgeInsets.only(left: 24.0, bottom: 16.0, right: 24.0),
        radius: 50.0,
        child: Row(
          children: [
            const SizedBox(width: 8.0),
            Expanded(child: _buildTextField()),
            _buildTranslateState(),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField() {
    return TextFormField(
      style: context.t.headlineSmall,
      controller: sourceController,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: const InputDecoration(
        hintText: 'Type Something...',
        fillColor: Colors.transparent,
      ),
    );
  }

  Widget _buildTranslateState() {
    return BlocBuilder<TranslateCubit, TranslateState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const SizedBox(
            width: UiConfig.buttonHeight,
            height: UiConfig.buttonHeight,
            child: CircularBusyIndicator(),
          );
        }
        return _buildTranslateButton(context);
      },
    );
  }

  Widget _buildTranslateButton(BuildContext context) {
    return Container(
      color: AppColors.primaryDark,
      child: IconButton(
        visualDensity: VisualDensity.compact,
        splashRadius: 20.0,
        icon: Icon(
          AppIcons.send,
          size: 22.0,
          color: context.c.background,
        ),
        onPressed: () {
          final source = sourceController.text.trim();
          if (source.isEmpty) return;
          setState(() => sourceController.clear());
          context.read<TranslateCubit>().translate(source);
        },
      ),
    );
  }
}
