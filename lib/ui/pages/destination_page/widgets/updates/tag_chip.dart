import 'package:flutter/material.dart';

import 'package:sahayatri/ui/styles/styles.dart';

class TagChip extends StatefulWidget {
  final String label;
  final void Function(String) onDelete;

  const TagChip({
    Key key,
    @required this.label,
    this.onDelete,
  })  : assert(label != null),
        super(key: key);

  @override
  _TagChipState createState() => _TagChipState();
}

class _TagChipState extends State<TagChip> with SingleTickerProviderStateMixin {
  AnimationController controller;

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
        key: ValueKey(widget.label),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32.0),
          border: Border.all(
            width: 0.5,
            color: AppColors.darkFaded,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.label,
              style: AppTextStyles.headline6,
            ),
            if (widget.onDelete != null) ...[
              const SizedBox(width: 2.0),
              GestureDetector(
                onTap: () async {
                  await controller.reverse();
                  widget.onDelete(widget.label);
                },
                child: Icon(
                  Icons.close,
                  size: 12.0,
                  color: AppColors.darkFaded,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
