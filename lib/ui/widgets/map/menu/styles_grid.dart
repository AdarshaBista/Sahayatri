import 'package:flutter/material.dart';

import 'package:sahayatri/app/constants/configs.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/prefs_cubit/prefs_cubit.dart';

import 'package:community_material_icon/community_material_icon.dart';
import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/common/elevated_card.dart';
import 'package:sahayatri/ui/widgets/buttons/column_button.dart';

class StylesGrid extends StatefulWidget {
  const StylesGrid();

  @override
  StylesGridState createState() => StylesGridState();
}

class StylesGridState extends State<StylesGrid> {
  String selectedStyle;

  @override
  void initState() {
    super.initState();
    selectedStyle = context.bloc<PrefsCubit>().prefs.mapStyle;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Map Style',
          style: AppTextStyles.small.bold.light,
        ),
        const SizedBox(height: 12.0),
        Flexible(child: _buildGrid(context)),
      ],
    );
  }

  Widget _buildGrid(BuildContext context) {
    return Wrap(
      spacing: 12.0,
      runSpacing: 12.0,
      children: _MapLayerData.layers.map((l) => _buildLayer(l)).toList(),
    );
  }

  Widget _buildLayer(_MapLayerData layer) {
    final isSelected = selectedStyle == layer.style;

    return GestureDetector(
      onTap: () {
        context.bloc<PrefsCubit>().changeMapLayer(layer.style);
        setState(() {
          selectedStyle = layer.style;
        });
      },
      child: SizedBox(
        width: 72.0,
        height: 72.0,
        child: ElevatedCard(
          color: isSelected ? AppColors.primaryDark : AppColors.light,
          child: Center(
            child: ColumnButton(
              label: layer.title,
              icon: layer.icon,
              color: isSelected ? AppColors.light : AppColors.dark,
            ),
          ),
        ),
      ),
    );
  }
}

class _MapLayerData {
  final String title;
  final String style;
  final IconData icon;

  const _MapLayerData({
    @required this.title,
    @required this.style,
    @required this.icon,
  })  : assert(title != null),
        assert(style != null),
        assert(icon != null);

  static const List<_MapLayerData> layers = [
    _MapLayerData(
      title: 'Dark',
      style: MapStyles.dark,
      icon: CommunityMaterialIcons.weather_night,
    ),
    _MapLayerData(
      title: 'Light',
      style: MapStyles.light,
      icon: CommunityMaterialIcons.weather_sunny,
    ),
    _MapLayerData(
      title: 'Streets',
      style: MapStyles.streets,
      icon: CommunityMaterialIcons.google_street_view,
    ),
    _MapLayerData(
      title: 'Satellite',
      style: MapStyles.satellite,
      icon: CommunityMaterialIcons.earth,
    ),
    _MapLayerData(
      title: 'Outdoors',
      style: MapStyles.outdoors,
      icon: CommunityMaterialIcons.hiking,
    ),
  ];
}
