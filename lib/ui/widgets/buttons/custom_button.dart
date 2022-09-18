import 'package:flutter/material.dart';

import 'package:sahayatri/core/constants/configs.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/animators/fade_animator.dart';

class CustomButton extends StatelessWidget {
  final bool outline;
  final bool expanded;
  final bool centered;
  final Color? color;
  final String? label;
  final IconData? icon;
  final VoidCallback? onTap;
  final Color? backgroundColor;

  const CustomButton({
    super.key,
    required this.onTap,
    this.outline = false,
    this.centered = true,
    this.expanded = true,
    this.icon,
    this.label,
    this.color,
    this.backgroundColor,
  }) : assert(icon != null || label != null);

  @override
  Widget build(BuildContext context) {
    final effectiveColor = color ?? context.c.primaryContainer;
    final splashColor = outline ? AppColors.primary : effectiveColor.withOpacity(0.4);

    return FadeAnimator(
      child: InkWell(
        onTap: onTap,
        splashColor: splashColor,
        borderRadius: BorderRadius.circular(6.0),
        child: expanded
            ? _buildButton(effectiveColor)
            : IntrinsicWidth(
                child: _buildButton(effectiveColor),
              ),
      ),
    );
  }

  Widget _buildButton(Color effectiveColor) {
    final bgColor = backgroundColor ?? AppColors.primaryLight;

    return Container(
      height: UiConfig.buttonHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6.0),
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
            if (icon != null)
              Icon(
                icon,
                size: 18.0,
                color: effectiveColor,
              ),
            if (icon != null && label != null) const SizedBox(width: 8.0),
            if (label != null)
              Flexible(
                child: Text(
                  label!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.headline5.withColor(effectiveColor),
                ),
              ),
            const SizedBox(width: 12.0),
          ],
        ),
      ),
    );
  }
}
