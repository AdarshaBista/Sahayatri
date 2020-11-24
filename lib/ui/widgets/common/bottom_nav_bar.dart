import 'package:flutter/material.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/animators/fade_animator.dart';
import 'package:sahayatri/ui/widgets/animators/slide_animator.dart';

class BottomNavBar extends StatelessWidget {
  final double iconSize;
  final int selectedIndex;
  final List<IconData> icons;
  final ValueChanged<int> onItemSelected;

  const BottomNavBar({
    this.selectedIndex = 0,
    @required this.icons,
    @required this.iconSize,
    @required this.onItemSelected,
  })  : assert(icons != null),
        assert(iconSize != null),
        assert(onItemSelected != null),
        assert(icons.length >= 2 && icons.length <= 5);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        width: double.infinity,
        height: 60.0,
        color: context.c.background,
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
        child: Row(
          children: icons.map((icon) {
            final int index = icons.indexOf(icon);
            final bool isSelected = index == selectedIndex;

            return Flexible(
              child: GestureDetector(
                onTap: () => onItemSelected(index),
                child: Container(
                  width: double.maxFinite,
                  color: Colors.transparent,
                  child: FadeAnimator(
                    child: SlideAnimator(
                      begin: Offset(0.0, 0.2 + index * 0.4),
                      child: _buildNavItem(context, icon, isSelected),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, IconData icon, bool isSelected) {
    return Column(
      children: [
        const SizedBox(height: 6.0),
        Icon(
          icon,
          size: iconSize,
          color: isSelected ? AppColors.primary : context.c.onSurface,
        ),
        AnimatedContainer(
          curve: Curves.easeOut,
          duration: const Duration(milliseconds: 120),
          width: isSelected ? 6.0 : 0.0,
          height: isSelected ? 6.0 : 0.0,
          margin:
              isSelected ? const EdgeInsets.all(4.0) : const EdgeInsets.only(top: 16.0),
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
      ],
    );
  }
}
