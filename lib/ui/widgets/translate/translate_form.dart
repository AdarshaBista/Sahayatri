import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/translate_cubit/translate_cubit.dart';

import 'package:loading_indicator/loading_indicator.dart';
import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/animators/fade_animator.dart';
import 'package:sahayatri/ui/widgets/animators/slide_animator.dart';
import 'package:sahayatri/ui/widgets/translate/translated_card.dart';
import 'package:sahayatri/ui/widgets/translate/translate_text_field.dart';
import 'package:sahayatri/ui/widgets/indicators/simple_busy_indicator.dart';

class TranslateForm extends StatelessWidget {
  final bool isOnSettings;

  const TranslateForm({
    @required this.isOnSettings,
  }) : assert(isOnSettings != null);

  @override
  Widget build(BuildContext context) {
    return AnimatedPadding(
      curve: Curves.decelerate,
      padding: MediaQuery.of(context).viewInsets,
      duration: const Duration(milliseconds: 200),
      child: FadeAnimator(
        child: isOnSettings
            ? SlideAnimator(
                begin: const Offset(0.0, 1.0),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 0.7,
                  ),
                  child: Scaffold(
                    resizeToAvoidBottomInset: false,
                    body: _buildList(context),
                  ),
                ),
              )
            : _buildList(context),
      ),
    );
  }

  Widget _buildList(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: isOnSettings
          ? const BouncingScrollPhysics()
          : const NeverScrollableScrollPhysics(),
      children: [
        Text('Translate', style: AppTextStyles.medium.bold),
        const SizedBox(height: 8.0),
        const TranslateTextField(),
        const SizedBox(height: 12.0),
        _buildResult(),
      ],
    );
  }

  Widget _buildResult() {
    return BlocBuilder<TranslateCubit, TranslateState>(
      builder: (context, state) {
        if (state is TranslateError) {
          return Text(state.message, style: AppTextStyles.small.secondary);
        } else if (state is TranslateLoading) {
          return _buildLoading();
        } else if (state is TranslateSuccess) {
          return TranslatedCard(translation: state.translation);
        } else {
          return const Offstage();
        }
      },
    );
  }

  Widget _buildLoading() {
    return Center(
      child: Container(
        width: 32.0,
        height: 32.0,
        margin: const EdgeInsets.all(12.0),
        child: LoadingIndicator(
          color: AppColors.primary,
          indicatorType: Indicator.ballSpinFadeLoader,
        ),
      ),
    );
  }
}
