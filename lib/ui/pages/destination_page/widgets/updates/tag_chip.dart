import 'package:flutter/material.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/animators/scale_animator.dart';

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
    final hPadding = widget.onSelect == null ? 8.0 : 12.0;
    final vPadding = widget.onSelect == null ? 4.0 : 6.0;

    return ScaleAnimator(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          decoration: getDecoration(),
          padding: EdgeInsets.symmetric(horizontal: hPadding, vertical: vPadding),
          child: DefaultTextStyle(
            child: Text(widget.label),
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
