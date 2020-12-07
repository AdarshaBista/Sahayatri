import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/prefs_cubit/prefs_cubit.dart';

import 'package:community_material_icon/community_material_icon.dart';
import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/common/custom_card.dart';
import 'package:sahayatri/ui/widgets/common/custom_tile.dart';

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
          child: CustomCard(
            borderRadius: 8.0,
            color: AppColors.darkFaded,
            padding: const EdgeInsets.all(10.0),
            child: _buildLayers(),
          ),
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
              value: mapLayers.route,
              icon: CommunityMaterialIcons.chart_line_variant,
              onSelect: (value) => context
                  .read<PrefsCubit>()
                  .saveMapLayers(mapLayers.copyWith(route: value)),
            ),
            const SizedBox(height: 10.0),
            _LayerTile(
              label: 'Flags',
              value: mapLayers.flags,
              icon: CommunityMaterialIcons.flag_outline,
              onSelect: (value) => context
                  .read<PrefsCubit>()
                  .saveMapLayers(mapLayers.copyWith(flags: value)),
            ),
            const SizedBox(height: 10.0),
            _LayerTile(
              label: 'Places',
              value: mapLayers.places,
              icon: CommunityMaterialIcons.map_marker_multiple_outline,
              onSelect: (value) => context
                  .read<PrefsCubit>()
                  .saveMapLayers(mapLayers.copyWith(places: value)),
            ),
            const SizedBox(height: 10.0),
            _LayerTile(
              label: 'Checkpoints',
              value: mapLayers.checkpoints,
              icon: CommunityMaterialIcons.map_marker_check_outline,
              onSelect: (value) => context
                  .read<PrefsCubit>()
                  .saveMapLayers(mapLayers.copyWith(checkpoints: value)),
            ),
            const SizedBox(height: 10.0),
            _LayerTile(
              label: 'Nearby Devices',
              value: mapLayers.nearbyDevices,
              icon: Icons.radio_button_checked,
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

class _LayerTile extends StatefulWidget {
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
  _LayerTileState createState() => _LayerTileState();
}

class _LayerTileState extends State<_LayerTile> {
  bool isChecked;

  @override
  void initState() {
    super.initState();
    isChecked = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return CustomTile(
      onTap: onTap,
      icon: widget.icon,
      title: widget.label,
      color: Colors.transparent,
      iconColor: AppColors.light,
      textStyle: AppTextStyles.headline5.light,
      trailing: Checkbox(
        value: isChecked,
        onChanged: (_) => onTap(),
        checkColor: AppColors.light,
        fillColor: MaterialStateProperty.all(AppColors.primaryDark),
      ),
    );
  }

  void onTap() {
    setState(() {
      isChecked = !isChecked;
    });
    widget.onSelect(isChecked);
  }
}
