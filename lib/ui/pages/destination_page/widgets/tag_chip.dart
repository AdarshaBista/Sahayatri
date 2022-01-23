import 'package:flutter/material.dart';

import 'package:sahayatri/ui/styles/styles.dart';

class TagChip extends StatefulWidget {
  final String label;
  final void Function(String)? onDelete;

  const TagChip({
    Key? key,
    required this.label,
    this.onDelete,
  }) : super(key: key);

  @override
  _TagChipState createState() => _TagChipState();
}

class _TagChipState extends State<TagChip> with SingleTickerProviderStateMixin {
  late final AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: CurvedAnimation(
        curve: Curves.elasticInOut,
        parent: controller,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32.0),
          border: Border.all(
            width: 0.5,
            color: context.c.onSurface,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Text(
                widget.label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: context.t.headline6,
              ),
            ),
            if (widget.onDelete != null) ...[
              const SizedBox(width: 2.0),
              Flexible(
                child: GestureDetector(
                  onTap: () async {
                    await controller.reverse();
                    widget.onDelete?.call(widget.label);
                  },
                  child: const Icon(
                    AppIcons.close,
                    size: 12.0,
                    color: AppColors.secondary,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
