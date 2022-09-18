import 'package:flutter/material.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/map/menu/layers_list.dart';
import 'package:sahayatri/ui/widgets/map/menu/styles_grid.dart';

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: ListView(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          padding:
              const EdgeInsets.symmetric(horizontal: 20.0, vertical: 132.0),
          children: [
            _buildCloseButton(context),
            const SizedBox(height: 20.0),
            const StylesGrid(),
            const SizedBox(height: 20.0),
            const LayersList(),
          ],
        ),
      ),
    );
  }

  Widget _buildCloseButton(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: GestureDetector(
        onTap: () => Navigator.of(context).pop(),
        child: const Icon(
          AppIcons.close,
          size: 24.0,
          color: AppColors.light,
        ),
      ),
    );
  }
}
