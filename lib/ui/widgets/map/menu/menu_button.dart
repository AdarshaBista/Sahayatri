import 'package:flutter/material.dart';

import 'package:community_material_icon/community_material_icon.dart';
import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/buttons/circular_button.dart';

class MenuButton extends StatelessWidget {
  const MenuButton();

  @override
  Widget build(BuildContext context) {
    return CircularButton(
      color: AppColors.primary,
      icon: CommunityMaterialIcons.layers_outline,
      onTap: () => Scaffold.of(context).openDrawer(),
    );
  }
}
