import 'package:flutter/material.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/animators/fade_animator.dart';
import 'package:sahayatri/ui/shared/animators/slide_animator.dart';

class BottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final List<IconData> icons;
  final ValueChanged<int> onItemSelected;

  BottomNavBar({
    this.selectedIndex = 0,
    @required this.icons,
    @required this.onItemSelected,
  })  : assert(icons != null),
        assert(onItemSelected != null),
        assert(icons.length >= 2 && icons.length <= 5);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        height: 64.0,
        color: AppColors.background,
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
        child: Row(
          children: icons.map((icon) {
            int index = icons.indexOf(icon);
            bool isSelected = index == selectedIndex;

            return Flexible(
              child: GestureDetector(
                onTap: () => onItemSelected(index),
                child: Container(
                  width: double.maxFinite,
                  color: Colors.transparent,
                  child: FadeAnimator(
                    child: SlideAnimator(
                      begin: Offset(0.0, 0.2 + index * 0.2),
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
          size: 24.0,
          color: isSelected ? AppColors.primary : AppColors.disabled,
        ),
        AnimatedContainer(
          curve: Curves.bounceIn,
          duration: const Duration(milliseconds: 300),
          width: isSelected ? 6 : 0,
          height: isSelected ? 6 : 0,
          margin: EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
      ],
    );
  }
}
