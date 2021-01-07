import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/lodge.dart';

import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/common/star_rating_bar.dart';

class HeaderTile extends StatelessWidget {
  const HeaderTile();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: _buildRating(context),
    );
  }

  Widget _buildRating(BuildContext context) {
    final rating = context.watch<Lodge>().rating;

    return Row(
      children: [
        StarRatingBar(
          size: 20.0,
          rating: rating,
        ),
        const SizedBox(width: 8.0),
        Text(
          '($rating)',
          style: context.t.headline5,
        ),
      ],
    );
  }
}
