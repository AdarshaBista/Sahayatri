import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/lodge.dart';

import 'package:provider/provider.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/widgets/star_rating_bar.dart';

class LodgeRating extends StatelessWidget {
  const LodgeRating();

  @override
  Widget build(BuildContext context) {
    final rating = context.watch<Lodge>().rating;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StarRatingBar(
            size: 20.0,
            rating: rating,
          ),
          const SizedBox(height: 4.0),
          Text(
            rating.toString(),
            style: AppTextStyles.large.bold,
          ),
        ],
      ),
    );
  }
}
