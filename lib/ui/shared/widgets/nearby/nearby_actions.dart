import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/blocs/nearby_bloc/nearby_bloc.dart';

import 'package:community_material_icon/community_material_icon.dart';
import 'package:sahayatri/ui/shared/widgets/nearby/nearby_button.dart';

class NearbyActions extends StatelessWidget {
  const NearbyActions();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        NearbyButton(
          label: 'Host',
          color: Colors.lightBlue,
          icon: CommunityMaterialIcons.circle_double,
          onTap: () => context.bloc<NearbyBloc>().add(const AdvertisingStarted()),
        ),
        const SizedBox(width: 12.0),
        NearbyButton(
          label: 'Join',
          color: Colors.green,
          icon: CommunityMaterialIcons.account_search_outline,
          onTap: () => context.bloc<NearbyBloc>().add(const DiscoveryStarted()),
        ),
      ],
    );
  }
}
