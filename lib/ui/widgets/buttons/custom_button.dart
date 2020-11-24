import 'package:flutter/material.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/animators/fade_animator.dart';

class CustomButton extends StatelessWidget {
  final Color color;
  final String label;
  final bool outline;
  final bool centered;
  final IconData icon;
  final VoidCallback onTap;
  final Color backgroundColor;

  const CustomButton({
    @required this.icon,
    @required this.label,
    @required this.onTap,
    this.outline = false,
    this.centered = true,
    this.color,
    this.backgroundColor,
  })  : assert(icon != null),
        assert(label != null),
        assert(outline != null),
        assert(centered != null);

  @override
  Widget build(BuildContext context) {
    final effectiveColor = color ?? context.c.primaryVariant;
    final bgColor = backgroundColor ?? AppColors.primaryLight;
    final splashColor = outline ? AppColors.primary : effectiveColor.withOpacity(0.4);

    return FadeAnimator(
      child: InkWell(
        onTap: onTap,
        splashColor: splashColor,
        borderRadius: BorderRadius.circular(4.0),
        child: Container(
          height: 36.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.0),
            color: outline ? Colors.transparent : bgColor,
            border: outline
                ? Border.all(
                    width: 0.8,
                    color: effectiveColor,
                  )
                : null,
          ),
          child: Center(
            child: Row(
              mainAxisSize: centered ? MainAxisSize.min : MainAxisSize.max,
              children: [
                const SizedBox(width: 12.0),
                Icon(
                  icon,
                  size: 18.0,
                  color: effectiveColor,
                ),
                const SizedBox(width: 8.0),
                Text(
                  label,
                  style: AppTextStyles.headline5.withColor(effectiveColor),
                ),
                const SizedBox(width: 12.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
