import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/coord.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/map/markers/icon_marker_widget.dart';
import 'package:sahayatri/ui/widgets/map/markers/arrow_marker_widget.dart';

class DynamicTextMarker extends Marker {
  DynamicTextMarker({
    @required Coord coord,
    @required IconData icon,
    @required bool shrinkWhen,
    String label,
    Function(BuildContext) onTap,
    Color color = AppColors.dark,
    Color backgroundColor = AppColors.light,
  })  : assert(icon != null),
        assert(color != null),
        assert(shrinkWhen != null),
        assert(backgroundColor != null),
        super(
          height: 44.0,
          width: shrinkWhen ? 24.0 : 120.0,
          point: coord.toLatLng(),
          anchorPos: AnchorPos.align(AnchorAlign.top),
          builder: (_) => _DynamicTextMarkerWidget(
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
  final String label;
  final IconData icon;
  final bool shrinkWhen;
  final Color backgroundColor;
  final Function(BuildContext) onTap;

  const _DynamicTextMarkerWidget({
    this.icon,
    this.label,
    this.color,
    this.onTap,
    this.shrinkWhen,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    if (shrinkWhen || label == null) {
      return IconMarkerWidget(
        icon: icon,
        color: color,
        onTap: () => onTap(context),
        backgroundColor: backgroundColor,
      );
    }

    return ArrowMarkerWidget(
      borderRadius: 32.0,
      color: backgroundColor,
      onTap: () => onTap(context),
      padding: const EdgeInsets.fromLTRB(4.0, 4.0, 8.0, 4.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 14.0,
            color: color,
          ),
          const SizedBox(width: 4.0),
          Flexible(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.headline6.withColor(color),
            ),
          ),
        ],
      ),
    );
  }
}
