import 'package:flutter/material.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/buttons/circular_button.dart';

class MenuButton extends StatelessWidget {
  const MenuButton();

  @override
  Widget build(BuildContext context) {
    return CircularButton(
      color: AppColors.primary,
      icon: AppIcons.layers,
      onTap: () => Scaffold.of(context).openDrawer(),
    );
  }
}
