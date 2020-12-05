import 'package:flutter/material.dart';

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
    return Column(
      children: const [
        LayerTile(
          label: 'Route',
          icon: CommunityMaterialIcons.chart_line_variant,
        ),
        SizedBox(height: 10.0),
        LayerTile(
          label: 'Flags',
          icon: CommunityMaterialIcons.flag_outline,
        ),
        SizedBox(height: 10.0),
        LayerTile(
          label: 'Places',
          icon: CommunityMaterialIcons.map_marker_multiple_outline,
        ),
        SizedBox(height: 10.0),
        LayerTile(
          label: 'Checkpoints',
          icon: CommunityMaterialIcons.map_marker_check_outline,
        ),
        SizedBox(height: 10.0),
        LayerTile(
          label: 'Nearby Devices',
          icon: Icons.radio_button_checked,
        ),
      ],
    );
  }
}

class LayerTile extends StatefulWidget {
  final String label;
  final IconData icon;

  const LayerTile({
    @required this.icon,
    @required this.label,
  })  : assert(icon != null),
        assert(label != null);

  @override
  _LayerTileState createState() => _LayerTileState();
}

class _LayerTileState extends State<LayerTile> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return CustomTile(
      icon: widget.icon,
      title: widget.label,
      color: Colors.transparent,
      textStyle: AppTextStyles.headline5.light,
      onTap: () {
        setState(() {
          isChecked = !isChecked;
        });
      },
      trailing: Checkbox(
        value: isChecked,
        checkColor: AppColors.light,
        fillColor: MaterialStateProperty.all(AppColors.primaryDark),
        onChanged: (value) {
          setState(() {
            isChecked = value;
          });
        },
      ),
    );
  }
}
