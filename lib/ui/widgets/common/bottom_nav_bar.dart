import 'package:flutter/material.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/animators/fade_animator.dart';
import 'package:sahayatri/ui/widgets/animators/slide_animator.dart';

class BottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final List<IconData> icons;
  final ValueChanged<int> onItemSelected;

  const BottomNavBar({
    this.selectedIndex = 0,
    @required this.icons,
    @required this.onItemSelected,
  })  : assert(icons != null),
        assert(onItemSelected != null),
        assert(icons.length >= 2 && icons.length <= 5);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        width: double.infinity,
        height: 64.0,
        color: AppColors.light,
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
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
                      child: _buildNavItem(icon, isSelected),
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

  Widget _buildNavItem(IconData icon, bool isSelected) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: 22.0,
          color: isSelected ? AppColors.primary : AppColors.disabled,
        ),
        AnimatedContainer(
          curve: Curves.bounceIn,
          duration: const Duration(milliseconds: 120),
          width: isSelected ? 6 : 0,
          height: isSelected ? 6 : 0,
          margin: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
      ],
    );
  }
}