import 'package:flutter/material.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/animators/fade_animator.dart';
import 'package:sahayatri/ui/widgets/animators/slide_animator.dart';
import 'package:sahayatri/ui/widgets/translate/translation_list.dart';
import 'package:sahayatri/ui/widgets/translate/language_selector.dart';
import 'package:sahayatri/ui/widgets/translate/translate_text_field.dart';

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
                child: SizedBox(
                  child: _buildContent(context),
                  height: MediaQuery.of(context).size.height * 0.8,
                ),
              )
            : _buildContent(context),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isOnSettings) const SizedBox(height: 8.0),
        Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0),
          child: Text('Translate', style: context.t.headline4.bold),
        ),
        Expanded(
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: const [
              TranslationList(),
              TranslateTextField(),
              Align(alignment: Alignment.topCenter, child: LanguageSelector()),
            ],
          ),
        ),
      ],
    );
  }
}
