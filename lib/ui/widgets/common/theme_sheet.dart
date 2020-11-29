import 'package:flutter/material.dart';

import 'package:community_material_icon/community_material_icon.dart';
import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/common/sheet_header.dart';
import 'package:sahayatri/ui/widgets/buttons/square_button.dart';

class ThemeSheet extends StatelessWidget {
  final void Function(bool) onSelect;

  const ThemeSheet({
    @required this.onSelect,
  }) : assert(onSelect != null);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SheetHeader(
            title: 'Change theme to',
            showDivider: false,
            onClose: Navigator.of(context).pop,
          ),
          const SizedBox(height: 12.0),
          Row(
            children: [
              SquareButton(
                label: 'LIGHT',
                color: AppColors.dark,
                backgroundColor: AppColors.lightAccent,
                icon: CommunityMaterialIcons.weather_sunny,
                onTap: () {
                  Navigator.of(context).pop();
                  onSelect(false);
                },
              ),
              const SizedBox(width: 12.0),
              SquareButton(
                label: 'DARK',
                color: AppColors.light,
                backgroundColor: AppColors.darkAccent,
                icon: CommunityMaterialIcons.weather_night,
                onTap: () {
                  Navigator.of(context).pop();
                  onSelect(true);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
