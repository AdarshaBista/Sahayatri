import 'package:flutter/material.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/animators/fade_animator.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final Color color;
  final Color backgroundColor;
  final bool outlineOnly;
  final IconData iconData;
  final VoidCallback onTap;

  const CustomButton({
    @required this.label,
    this.color = AppColors.light,
    this.backgroundColor,
    this.outlineOnly = false,
    @required this.iconData,
    @required this.onTap,
  })  : assert(label != null),
        assert(color != null),
        assert(outlineOnly != null),
        assert(iconData != null);

  @override
  Widget build(BuildContext context) {
    final bgColor = backgroundColor ?? context.c.onBackground;

    return FadeAnimator(
      child: SizedBox(
        height: 36.0,
        child: outlineOnly
            ? OutlineButton.icon(
                onPressed: onTap,
                splashColor: color.withOpacity(0.3),
                highlightedBorderColor: bgColor,
                borderSide: BorderSide(color: bgColor),
                icon: Icon(iconData, color: color),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
                label: Text(
                  label,
                  style: AppTextStyles.headline5.withColor(color),
                ),
              )
            : FlatButton.icon(
                onPressed: onTap,
                color: bgColor,
                icon: Icon(iconData, color: color),
                splashColor: color.withOpacity(0.3),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
                label: Text(
                  label,
                  style: AppTextStyles.headline5.withColor(color),
                ),
              ),
      ),
    );
  }
}
