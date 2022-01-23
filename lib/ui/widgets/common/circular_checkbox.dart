import 'package:flutter/material.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/buttons/circular_button.dart';

class CircularCheckbox extends StatefulWidget {
  final bool value;
  final Function(bool) onSelect;
  final Color? color;

  const CircularCheckbox({
    this.color,
    required this.value,
    required this.onSelect,
  });

  @override
  _CircularCheckboxState createState() => _CircularCheckboxState();
}

class _CircularCheckboxState extends State<CircularCheckbox> {
  late bool isChecked;

  @override
  void initState() {
    super.initState();
    isChecked = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return CircularButton(
      onTap: onTap,
      size: 16.0,
      padding: 4.0,
      icon: isChecked ? AppIcons.confirm : AppIcons.close,
      color: widget.color ?? context.c.onBackground,
      backgroundColor:
          isChecked ? AppColors.primaryLight : AppColors.secondaryLight,
    );
  }

  void onTap() {
    setState(() {
      isChecked = !isChecked;
    });
    widget.onSelect(isChecked);
  }
}
