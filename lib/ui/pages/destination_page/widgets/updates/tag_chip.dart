import 'package:flutter/material.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/animators/scale_animator.dart';

class TagChip extends StatefulWidget {
  final String label;
  final void Function(String) onSelect;

  const TagChip({
    @required this.label,
    this.onSelect,
  }) : assert(label != null);

  @override
  _TagChipState createState() => _TagChipState();
}

class _TagChipState extends State<TagChip> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return ScaleAnimator(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: getDecoration(),
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
          child: Text(
            widget.label,
            style: isSelected ? AppTextStyles.extraSmall.light : AppTextStyles.extraSmall,
          ),
        ),
      ),
    );
  }

  BoxDecoration getDecoration() {
    return BoxDecoration(
      color: isSelected ? AppColors.primaryDark : Colors.transparent,
      borderRadius: BorderRadius.circular(32.0),
      border: Border.all(
        width: 0.5,
        color: isSelected ? Colors.transparent : AppColors.barrier,
      ),
      boxShadow: isSelected
          ? [
              BoxShadow(
                blurRadius: 4.0,
                spreadRadius: 4.0,
                color: AppColors.dark.withOpacity(0.15),
              ),
            ]
          : null,
    );
  }

  void onTap() {
    if (widget.onSelect == null) return;
    setState(() => isSelected = !isSelected);
    widget.onSelect(widget.label);
  }
}