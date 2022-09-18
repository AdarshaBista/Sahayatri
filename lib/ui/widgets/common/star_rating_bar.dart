import 'package:flutter/material.dart';

import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/animators/fade_animator.dart';
import 'package:sahayatri/ui/widgets/animators/slide_animator.dart';

class StarRatingBar extends StatelessWidget {
  final double size;
  final double rating;
  final Function(double)? onUpdate;

  const StarRatingBar({
    super.key,
    required this.rating,
    this.size = 24.0,
    this.onUpdate,
  });

  @override
  Widget build(BuildContext context) {
    final color = rating < 3.0 ? AppColors.secondary : AppColors.primary;

    return FadeAnimator(
      child: RatingBar.builder(
        maxRating: 5.0,
        itemSize: size,
        glowColor: color,
        updateOnDrag: true,
        allowHalfRating: true,
        initialRating: rating,
        unratedColor: context.c.surface,
        itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
        ignoreGestures: onUpdate == null,
        onRatingUpdate: (newRating) => onUpdate?.call(newRating),
        itemBuilder: (_, index) {
          final IconData iconData =
              index < rating ? AppIcons.starFilled : AppIcons.star;
          final Icon icon = Icon(
            iconData,
            color: color,
          );

          return onUpdate == null
              ? SlideAnimator(
                  begin: Offset(0.2 + index * 0.4, 0.0),
                  child: icon,
                )
              : icon;
        },
      ),
    );
  }
}
