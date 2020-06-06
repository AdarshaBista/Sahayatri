import 'package:flutter/material.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/widgets/custom_card.dart';
import 'package:sahayatri/ui/shared/animators/fade_animator.dart';
import 'package:sahayatri/ui/shared/animators/scale_animator.dart';
import 'package:sahayatri/ui/shared/animators/slide_animator.dart';

class SearchBox extends StatelessWidget {
  final String hintText;
  final double elevation;
  final Function(String) onChanged;

  const SearchBox({
    this.hintText = 'Search',
    this.elevation = 8.0,
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
          height: 50.0,
          child: CustomCard(
            elevation: elevation,
            child: TextField(
              maxLines: 1,
              onChanged: onChanged,
              style: AppTextStyles.small,
              decoration: InputDecoration(
                fillColor: AppColors.light,
                border: InputBorder.none,
                hintText: hintText,
                prefixIcon: ScaleAnimator(
                  child: Icon(
                    Icons.search,
                    size: 20.0,
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
