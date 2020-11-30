import 'package:flutter/material.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/common/elevated_card.dart';
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
        child: SizedBox(
          width: double.infinity,
          height: 42.0,
          child: ElevatedCard(
            margin: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Center(
              child: TextField(
                onChanged: onChanged,
                style: context.t.headline5,
                decoration: InputDecoration(
                  hintText: hintText,
                  border: InputBorder.none,
                  fillColor: Colors.transparent,
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
      ),
    );
  }
}
