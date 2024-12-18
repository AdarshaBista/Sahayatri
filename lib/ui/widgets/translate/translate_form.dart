import 'package:flutter/material.dart';

import 'package:sahayatri/ui/widgets/animators/fade_animator.dart';
import 'package:sahayatri/ui/widgets/animators/slide_animator.dart';
import 'package:sahayatri/ui/widgets/common/header.dart';
import 'package:sahayatri/ui/widgets/translate/language_selector.dart';
import 'package:sahayatri/ui/widgets/translate/translate_text_field.dart';
import 'package:sahayatri/ui/widgets/translate/translation_list.dart';

class TranslateForm extends StatelessWidget {
  final bool resizeToAvoidBottomInset;

  const TranslateForm({
    super.key,
    this.resizeToAvoidBottomInset = false,
  });

  @override
  Widget build(BuildContext context) {
    return FadeAnimator(
      child: SlideAnimator(
        begin: const Offset(0.0, 1.0),
        child: SizedBox(
          child: _buildContent(context),
          height: MediaQuery.of(context).size.height * 0.8,
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12.0),
        const Header(
          title: 'Translate',
          padding: 16.0,
          fontSize: 20.0,
        ),
        Expanded(
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              const TranslationList(),
              TranslateTextField(
                resizeToAvoidBottomInset: resizeToAvoidBottomInset,
              ),
              const Align(
                alignment: Alignment.topCenter,
                child: LanguageSelector(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
