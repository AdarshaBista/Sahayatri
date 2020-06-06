import 'package:flutter/material.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:sahayatri/ui/shared/animators/fade_animator.dart';
import 'package:sahayatri/ui/shared/animators/slide_animator.dart';

class StarRatingBar extends StatelessWidget {
  final double size;
  final double rating;
  final Function(double) onUpdate;

  const StarRatingBar({
    this.size = 24.0,
    this.onUpdate,
    @required this.rating,
  })  : assert(size != null),
        assert(rating != null);

  @override
  Widget build(BuildContext context) {
    final color = rating < 3.0 ? Colors.redAccent : AppColors.primary;
    return FadeAnimator(
      child: RatingBar(
        itemCount: 5,
        minRating: 0.0,
        maxRating: 5.0,
        itemSize: size,
        glowColor: color,
        glow: true,
        allowHalfRating: true,
        initialRating: rating,
        direction: Axis.horizontal,
        unratedColor: AppColors.light,
        itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
        ignoreGestures: onUpdate == null,
        onRatingUpdate: onUpdate,
        itemBuilder: (_, index) => SlideAnimator(
          begin: Offset(0.2 + index * 0.2, 0.0),
          child: Icon(
            Icons.star,
            color: color,
          ),
        ),
      ),
    );
  }
}
