import 'package:flutter/material.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/common/icon_label.dart';

class NotifyContactStatus extends StatelessWidget {
  final bool isNotified;

  const NotifyContactStatus({
    @required this.isNotified,
  }) : assert(isNotified != null);

  @override
  Widget build(BuildContext context) {
    final icon = isNotified ? AppIcons.check : AppIcons.close;
    final color = isNotified ? AppColors.primaryDark : AppColors.secondary;

    return IconLabel(
      icon: icon,
      iconColor: color,
      label: 'Notify Contact',
      labelStyle: AppTextStyles.headline6.withColor(color),
    );
  }
}
