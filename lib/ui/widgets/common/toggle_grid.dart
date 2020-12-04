import 'package:flutter/material.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/buttons/square_button.dart';

class ToggleGrid<T> extends StatefulWidget {
  final String title;
  final T initialValue;
  final Function(T) onSelected;
  final List<ToggleItem<T>> items;
  final Color iconColor;
  final TextStyle titleStyle;
  final Color backgroundColor;

  const ToggleGrid({
    this.iconColor,
    this.titleStyle,
    this.backgroundColor,
    @required this.title,
    @required this.items,
    @required this.onSelected,
    @required this.initialValue,
  })  : assert(title != null),
        assert(items != null),
        assert(onSelected != null),
        assert(initialValue != null);

  @override
  _ToggleGridState<T> createState() => _ToggleGridState<T>();
}

class _ToggleGridState<T> extends State<ToggleGrid<T>> {
  T selectedItem;

  @override
  void initState() {
    super.initState();
    selectedItem = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4.0),
          child: Text(
            widget.title,
            style: widget.titleStyle ?? context.t.headline5.bold,
          ),
        ),
        const SizedBox(height: 10.0),
        Flexible(child: _buildGrid(context)),
      ],
    );
  }

  Widget _buildGrid(BuildContext context) {
    return Wrap(
      spacing: 10.0,
      runSpacing: 10.0,
      children: widget.items.map((t) => _buildItem(t)).toList(),
    );
  }

  Widget _buildItem(ToggleItem<T> t) {
    final isSelected = selectedItem == t.value;

    return SquareButton(
      size: 72.0,
      icon: t.icon,
      label: t.label,
      color: widget.iconColor,
      backgroundColor: isSelected
          ? AppColors.primaryLight
          : widget.backgroundColor ?? context.c.surface,
      onTap: () {
        setState(() {
          selectedItem = t.value;
        });
        widget.onSelected(t.value);
      },
    );
  }
}

class ToggleItem<T> {
  final T value;
  final String label;
  final IconData icon;

  ToggleItem({
    @required this.icon,
    @required this.label,
    @required this.value,
  })  : assert(icon != null),
        assert(value != null),
        assert(label != null);
}
