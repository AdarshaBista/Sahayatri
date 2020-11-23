import 'package:flutter/material.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/common/elevated_card.dart';
import 'package:sahayatri/ui/widgets/animators/fade_animator.dart';
import 'package:sahayatri/ui/widgets/animators/scale_animator.dart';
import 'package:sahayatri/ui/widgets/animators/slide_animator.dart';

class SearchBox extends StatelessWidget {
  final String hintText;
  final double elevation;
  final Function(String) onChanged;

  const SearchBox({
    this.hintText = 'Search',
    this.elevation = 4.0,
    @required this.onChanged,
  })  : assert(hintText != null),
        assert(elevation != null),
        assert(onChanged != null);

  @override
  Widget build(BuildContext context) {
    return SlideAnimator(
      begin: const Offset(0.0, -0.2),
      child: FadeAnimator(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16.0),
          width: double.infinity,
          height: 44.0,
          child: ElevatedCard(
            elevation: elevation + 2.0,
            child: Center(
              child: TextField(
                onChanged: onChanged,
                style: context.t.headline5,
                decoration: InputDecoration(
                  fillColor: Colors.transparent,
                  border: InputBorder.none,
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
      ),
    );
  }
}
