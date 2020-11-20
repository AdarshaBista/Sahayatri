import 'package:flutter/material.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/animators/fade_animator.dart';
import 'package:sahayatri/ui/widgets/animators/slide_animator.dart';

class TagChip extends StatelessWidget {
  final String label;
  final void Function(String) onDelete;

  const TagChip({
    @required this.label,
    this.onDelete,
  }) : assert(label != null);

  @override
  Widget build(BuildContext context) {
    return FadeAnimator(
      child: SlideAnimator(
        duration: 200,
        begin: const Offset(0.0, -2.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32.0),
            border: Border.all(
              width: 0.5,
              color: AppColors.barrier,
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: AppTextStyles.extraSmall,
              ),
              if (onDelete != null) ...[
                const SizedBox(width: 2.0),
                GestureDetector(
                  onTap: () => onDelete(label),
                  child: Icon(
                    Icons.close,
                    size: 12.0,
                    color: AppColors.barrier,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
