import 'package:flutter/material.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/common/icon_label.dart';
import 'package:sahayatri/ui/widgets/views/animated_tab_view.dart';
import 'package:sahayatri/ui/widgets/animators/scale_animator.dart';

class NestedTabView extends StatefulWidget {
  final bool keepAlive;
  final bool isCentered;
  final bool isTabFilled;
  final bool showIndicator;
  final List<Widget> children;
  final List<NestedTabData> tabs;

  const NestedTabView({
    required this.tabs,
    required this.children,
    this.keepAlive = false,
    this.isCentered = false,
    this.isTabFilled = false,
    this.showIndicator = true,
  })  : assert(tabs != null),
        assert(children != null),
        assert(keepAlive != null),
        assert(isCentered != null),
        assert(isTabFilled != null),
        assert(showIndicator != null),
        assert(tabs.length == children.length);

  @override
  _NestedTabViewState createState() => _NestedTabViewState();
}

class _NestedTabViewState extends State<NestedTabView> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: widget.isCentered
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16.0),
        _buildTabBar(context),
        AnimatedTabView(
          index: _selectedIndex,
          children: widget.children,
          keepAlive: widget.keepAlive,
        ),
      ],
    );
  }

  Widget _buildTabBar(BuildContext context) {
    final height = widget.isTabFilled ? 38.0 : 32.0;
    final borderRadius = widget.isTabFilled ? 32.0 : 0.0;
    final color =
        widget.isTabFilled ? context.c.background : Colors.transparent;
    final padding =
        widget.isTabFilled ? const EdgeInsets.all(4.0) : EdgeInsets.zero;

    return Container(
      height: height,
      padding: padding,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: widget.tabs.length,
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        separatorBuilder: (_, __) => const SizedBox(width: 20.0),
        itemBuilder: (context, index) {
          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => setState(() => _selectedIndex = index),
            child: NestedTab(
              tab: widget.tabs[index],
              showIndicator: widget.showIndicator,
              isSelected: index == _selectedIndex,
            ),
          );
        },
      ),
    );
  }
}

class NestedTab extends StatelessWidget {
  final bool isSelected;
  final NestedTabData tab;
  final bool showIndicator;

  const NestedTab({
    required this.tab,
    required this.isSelected,
    required this.showIndicator,
  })  : assert(tab != null),
        assert(isSelected != null),
        assert(showIndicator != null);

  @override
  Widget build(BuildContext context) {
    return ScaleAnimator(
      child: !showIndicator
          ? _buildTab(context)
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTab(context),
                const SizedBox(height: 5.0),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  height: isSelected ? 2.0 : 0.0,
                  width: isSelected ? 40.0 : 0.0,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(2.0),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildTab(BuildContext context) {
    final color = !showIndicator && isSelected
        ? AppColors.primaryDark
        : context.c.onBackground;

    return IconLabel(
      iconSize: 18.0,
      icon: tab.icon,
      label: tab.label,
      iconColor: color,
      labelStyle: context.t.headline5.bold.withColor(color),
    );
  }
}

class NestedTabData {
  final String label;
  final IconData icon;

  NestedTabData({
    required this.label,
    required this.icon,
  })  : assert(label != null),
        assert(icon != null);
}
