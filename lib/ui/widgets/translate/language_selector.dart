import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/language.dart';

import 'package:sahayatri/app/constants/languages.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/translate_cubit/translate_cubit.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/animators/scale_animator.dart';

class LanguageSelector extends StatefulWidget {
  const LanguageSelector();

  @override
  _LanguageSelectorState createState() => _LanguageSelectorState();
}

class _LanguageSelectorState extends State<LanguageSelector> {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: const _Painter(),
      child: Padding(
        padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildLanguageMenu(false, context.bloc<TranslateCubit>().sourceLang),
            const SizedBox(width: 12.0),
            _buildFlipButton(),
            const SizedBox(width: 12.0),
            _buildLanguageMenu(true, context.bloc<TranslateCubit>().targetLang),
          ],
        ),
      ),
    );
  }

  Widget _buildFlipButton() {
    return GestureDetector(
      onTap: () {
        context.bloc<TranslateCubit>().flipLanguages();
        setState(() {});
      },
      child: const Icon(
        Icons.compare_arrows,
        color: AppColors.primaryDark,
      ),
    );
  }

  Widget _buildLanguageMenu(bool isTarget, Language language) {
    return ScaleAnimator(
      duration: 600,
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.24,
        child: PopupMenuButton<Language>(
          initialValue: language,
          color: AppColors.light,
          onSelected: (value) => _changeLanguage(isTarget, value),
          child: Text(
            language.title.toUpperCase(),
            style: AppTextStyles.small.bold,
            overflow: TextOverflow.ellipsis,
            textAlign: isTarget ? TextAlign.left : TextAlign.right,
          ),
          itemBuilder: (context) {
            return Languages.all
                .map((l) => PopupMenuItem(
                      value: l,
                      child: Text(
                        l.title,
                        style: AppTextStyles.small.bold,
                      ),
                    ))
                .toList();
          },
        ),
      ),
    );
  }

  void _changeLanguage(bool isTarget, Language language) {
    if (isTarget) {
      context.bloc<TranslateCubit>().targetLang = language;
    } else {
      context.bloc<TranslateCubit>().sourceLang = language;
    }

    setState(() {});
  }
}

class _Painter extends CustomPainter {
  const _Painter();

  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width;
    final height = size.height;
    const color = AppColors.light;

    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final top = height * 0.25;
    final bottom = height;

    final leftStart = width * 0.1;
    final leftEnd = leftStart + 40.0;
    final leftCtrlTop = leftStart + 20.0;
    final leftCtrlBottom = leftEnd - 20.0;

    final rightEnd = width * 0.9;
    final rightStart = rightEnd - 40.0;
    final rightCtrlTop = rightEnd - 20.0;
    final rightCtrlBottom = rightStart + 20.0;

    final curve = Path()
      ..lineTo(0.0, top)
      ..lineTo(leftStart, top)
      ..cubicTo(leftCtrlTop, top, leftCtrlBottom, bottom, leftEnd, bottom)
      ..lineTo(rightStart, bottom)
      ..cubicTo(rightCtrlBottom, bottom, rightCtrlTop, top, rightEnd, top)
      ..lineTo(width, top)
      ..lineTo(width, 0.0)
      ..lineTo(0.0, 0.0);

    canvas.drawShadow(curve, AppColors.dark.withOpacity(0.3), 3.0, false);
    canvas.drawPath(curve, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
