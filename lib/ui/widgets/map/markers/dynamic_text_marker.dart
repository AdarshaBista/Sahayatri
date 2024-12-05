import 'package:flutter/material.dart';

import 'package:flutter_map/flutter_map.dart';

import 'package:sahayatri/core/models/coord.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/common/icon_label.dart';
import 'package:sahayatri/ui/widgets/map/markers/arrow_marker_widget.dart';
import 'package:sahayatri/ui/widgets/map/markers/icon_marker_widget.dart';

class DynamicTextMarker extends Marker {
  DynamicTextMarker({
    required Coord coord,
    required IconData icon,
    required bool shrinkWhen,
    Color color = AppColors.dark,
    Color backgroundColor = AppColors.light,
    String? label,
    void Function(BuildContext)? onTap,
  }) : super(
          height: shrinkWhen ? 28.0 : 44.0,
          width: shrinkWhen ? 28.0 : 120.0,
          point: coord.toLatLng(),
          alignment: Alignment.topCenter,
          child: _DynamicTextMarkerWidget(
            icon: icon,
            label: label,
            color: color,
            onTap: onTap,
            shrinkWhen: shrinkWhen,
            backgroundColor: backgroundColor,
          ),
        );
}

class _DynamicTextMarkerWidget extends StatelessWidget {
  final Color color;
  final IconData icon;
  final bool shrinkWhen;
  final Color backgroundColor;
  final void Function(BuildContext)? onTap;
  final String? label;

  const _DynamicTextMarkerWidget({
    required this.icon,
    required this.color,
    required this.shrinkWhen,
    required this.backgroundColor,
    this.onTap,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    if (shrinkWhen || label == null) {
      return IconMarkerWidget(
        icon: icon,
        color: backgroundColor,
        onTap: () => onTap?.call(context),
      );
    }

    return ArrowMarkerWidget(
      borderRadius: 32.0,
      color: backgroundColor,
      onTap: () => onTap?.call(context),
      padding: const EdgeInsets.fromLTRB(4.0, 4.0, 8.0, 4.0),
      child: IconLabel(
        icon: icon,
        label: label!,
        iconSize: 14.0,
        iconColor: color,
        labelStyle: AppTextStyles.headline6.withColor(color),
      ),
    );
  }
}
