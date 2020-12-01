import 'package:flutter/material.dart';

import 'package:sahayatri/app/constants/configs.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/animators/fade_animator.dart';
import 'package:sahayatri/ui/widgets/animators/scale_animator.dart';
import 'package:sahayatri/ui/widgets/animators/slide_animator.dart';

class SearchBox extends StatelessWidget {
  final String hintText;
  final Function(String) onChanged;

  const SearchBox({
    this.hintText = 'Search',
    @required this.onChanged,
  })  : assert(hintText != null),
        assert(onChanged != null);

  @override
  Widget build(BuildContext context) {
    return SlideAnimator(
      begin: const Offset(0.0, -0.2),
      child: FadeAnimator(
        child: Container(
          height: UiConfig.buttonHeight,
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Center(
            child: TextField(
              onChanged: onChanged,
              style: context.t.headline5,
              decoration: InputDecoration(
                hintText: hintText,
                prefixIcon: ScaleAnimator(
                  child: Icon(
                    Icons.search,
                    size: 20.0,
                    color: context.c.onSurface,
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
