import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/blocs/nearby_bloc/nearby_bloc.dart';

import 'package:sahayatri/core/models/nearby_device.dart';

import 'package:sahayatri/ui/styles/styles.dart';

class ConnectedList extends StatelessWidget {
  const ConnectedList();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NearbyBloc, NearbyState>(
      builder: (context, state) {
        return (state as NearbyInProgress).connected.isEmpty
            ? Text(
                'No devices found yet.',
                style: AppTextStyles.small.secondary,
              )
            : _buildList((state as NearbyInProgress).connected);
      },
    );
  }

  Widget _buildList(List<NearbyDevice> connected) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: connected.length,
      itemBuilder: (context, index) {
        return ListTile(
          dense: true,
          contentPadding: EdgeInsets.zero,
          title: Text(
            connected[index].name,
            style: AppTextStyles.medium,
          ),
          leading: CircleAvatar(
            radius: 14.0,
            backgroundColor: AppColors.primary.withOpacity(0.4),
            child: Text(
              '${index + 1}',
              style: AppTextStyles.small.bold,
            ),
          ),
        );
      },
    );
  }
}
