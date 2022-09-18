import 'package:flutter/material.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/animators/fade_animator.dart';
import 'package:sahayatri/ui/widgets/animators/scale_animator.dart';
import 'package:sahayatri/ui/widgets/animators/slide_animator.dart';
import 'package:sahayatri/ui/widgets/common/elevated_card.dart';

class SearchBox extends StatelessWidget {
  final String hintText;
  final Function(String) onChanged;

  const SearchBox({
    super.key,
    this.hintText = 'Search',
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SlideAnimator(
      begin: const Offset(0.0, -0.2),
      child: FadeAnimator(
        child: SizedBox(
          height: 44.0,
          child: ElevatedCard(
            margin: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Center(
              child: TextField(
                onChanged: onChanged,
                style: context.t.headline5,
                decoration: InputDecoration(
                  hintText: hintText,
                  fillColor: context.theme.cardColor,
                  prefixIcon: ScaleAnimator(
                    child: Icon(
                      AppIcons.search,
                      size: 20.0,
                      color: context.c.onSurface,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
