import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/blocs/destination_bloc/destination_bloc.dart';

import 'package:sahayatri/ui/shared/widgets/header.dart';
import 'package:sahayatri/ui/shared/animators/fade_animator.dart';
import 'package:sahayatri/ui/pages/destination_detail_page.dart/widgets/place/place_card.dart';

class PlacesGrid extends StatelessWidget {
  const PlacesGrid();

  @override
  Widget build(BuildContext context) {
    final places = context.bloc<DestinationBloc>().destination.places;

    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        Header(title: 'Places'),
        FadeAnimator(
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 10 / 13,
              crossAxisSpacing: 12.0,
              mainAxisSpacing: 12.0,
            ),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.only(
              top: 20.0,
              left: 20.0,
              right: 20.0,
              bottom: 40.0,
            ),
            itemCount: places.length,
            itemBuilder: (context, index) {
              return PlaceCard(place: places[index]);
            },
          ),
        ),
      ],
    );
  }
}
