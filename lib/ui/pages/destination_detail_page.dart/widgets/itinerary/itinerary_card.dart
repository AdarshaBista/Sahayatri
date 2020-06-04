import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/itinerary.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/blocs/destination_bloc/destination_bloc.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/animators/fade_animator.dart';
import 'package:sahayatri/ui/pages/destination_detail_page.dart/widgets/itinerary/itinerary_details.dart';

class ItineraryCard extends StatelessWidget {
  final Itinerary itinerary;
  final bool deletable;

  const ItineraryCard({
    @required this.itinerary,
    this.deletable = false,
  })  : assert(itinerary != null),
        assert(deletable != null);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => ItineraryDetails.show(context, itinerary),
      child: FadeAnimator(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 6.0),
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          decoration: BoxDecoration(
            color: AppColors.light,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: ListTile(
            title: Text(
              itinerary.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.medium.bold,
            ),
            subtitle: Text(
              '${itinerary.days} days ${itinerary.nights} nights',
              style: AppTextStyles.small,
            ),
            trailing: deletable
                ? IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => context.bloc<DestinationBloc>().add(
                          ItineraryCreated(itinerary: null),
                        ),
                  )
                : Offstage(),
          ),
        ),
      ),
    );
  }
}
