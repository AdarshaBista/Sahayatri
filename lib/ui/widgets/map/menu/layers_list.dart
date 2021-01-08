import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/prefs_cubit/prefs_cubit.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/common/custom_card.dart';
import 'package:sahayatri/ui/widgets/common/custom_tile.dart';
import 'package:sahayatri/ui/widgets/common/circular_checkbox.dart';

class LayersList extends StatelessWidget {
  const LayersList();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Layers',
          style: AppTextStyles.headline3.thin.light,
        ),
        const SizedBox(height: 10.0),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.75,
          child: _buildLayers(),
        ),
      ],
    );
  }

  Widget _buildLayers() {
    return BlocBuilder<PrefsCubit, PrefsState>(
      buildWhen: (p, c) => p.prefs.mapLayers != c.prefs.mapLayers,
      builder: (context, state) {
        final mapLayers = state.prefs.mapLayers;

        return Column(
          children: [
            _LayerTile(
              label: 'Route',
              icon: AppIcons.route,
              value: mapLayers.route,
              onSelect: (value) => context
                  .read<PrefsCubit>()
                  .saveMapLayers(mapLayers.copyWith(route: value)),
            ),
            const SizedBox(height: 10.0),
            _LayerTile(
              label: 'Places',
              icon: AppIcons.place,
              value: mapLayers.places,
              onSelect: (value) => context
                  .read<PrefsCubit>()
                  .saveMapLayers(mapLayers.copyWith(places: value)),
            ),
            const SizedBox(height: 10.0),
            _LayerTile(
              label: 'Checkpoints',
              icon: AppIcons.checkpoint,
              value: mapLayers.checkpoints,
              onSelect: (value) => context
                  .read<PrefsCubit>()
                  .saveMapLayers(mapLayers.copyWith(checkpoints: value)),
            ),
            const SizedBox(height: 10.0),
            _LayerTile(
              label: 'Nearby Devices',
              value: mapLayers.nearbyDevices,
              icon: AppIcons.nearbyDevice,
              onSelect: (value) => context
                  .read<PrefsCubit>()
                  .saveMapLayers(mapLayers.copyWith(nearbyDevices: value)),
            ),
          ],
        );
      },
    );
  }
}

class _LayerTile extends StatelessWidget {
  final bool value;
  final String label;
  final IconData icon;
  final Function(bool) onSelect;

  const _LayerTile({
    @required this.icon,
    @required this.value,
    @required this.label,
    @required this.onSelect,
  })  : assert(icon != null),
        assert(value != null),
        assert(label != null),
        assert(onSelect != null);

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      borderRadius: 8.0,
      color: AppColors.darkFaded,
      padding: const EdgeInsets.all(4.0),
      child: CustomTile(
        icon: icon,
        title: label,
        color: Colors.transparent,
        iconColor: AppColors.light,
        textStyle: AppTextStyles.headline5.light,
        trailing: CircularCheckbox(
          value: value,
          onSelect: onSelect,
          color: AppColors.light,
        ),
      ),
    );
  }
}
