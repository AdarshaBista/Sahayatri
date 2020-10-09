import 'package:flutter/material.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/animators/fade_animator.dart';

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
    this.backgroundColor = AppColors.dark,
    this.outlineOnly = false,
    @required this.iconData,
    @required this.onTap,
  })  : assert(label != null),
        assert(color != null),
        assert(backgroundColor != null),
        assert(outlineOnly != null),
        assert(iconData != null);

  @override
  Widget build(BuildContext context) {
    return FadeAnimator(
      child: SizedBox(
        height: 36.0,
        child: outlineOnly
            ? OutlineButton.icon(
                onPressed: onTap,
                splashColor: color.withOpacity(0.5),
                highlightedBorderColor: backgroundColor,
                borderSide: BorderSide(color: backgroundColor),
                icon: Icon(iconData, color: color),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
                label: Text(
                  label,
                  style: AppTextStyles.small.withColor(color),
                ),
              )
            : FlatButton.icon(
                onPressed: onTap,
                color: backgroundColor,
                icon: Icon(iconData, color: color),
                splashColor: color.withOpacity(0.5),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
                label: Text(
                  label,
                  style: AppTextStyles.small.withColor(color),
                ),
              ),
      ),
    );
  }
}
