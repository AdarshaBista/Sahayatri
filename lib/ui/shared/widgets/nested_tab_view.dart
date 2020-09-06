import 'package:flutter/material.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/animators/scale_animator.dart';

class NestedTabView extends StatefulWidget {
  final bool keepAlive;
  final bool isCentered;
  final bool isTabFilled;
  final List<Widget> children;
  final List<NestedTabData> tabs;
  final EdgeInsetsGeometry tabBarMargin;
  final EdgeInsetsGeometry tabBarPadding;

  const NestedTabView({
    @required this.tabs,
    @required this.children,
    this.keepAlive = false,
    this.isCentered = false,
    this.isTabFilled = false,
    this.tabBarPadding = const EdgeInsets.symmetric(vertical: 8.0),
    this.tabBarMargin = const EdgeInsets.symmetric(horizontal: 20.0),
  })  : assert(tabs != null),
        assert(isTabFilled != null),
        assert(children != null),
        assert(tabBarPadding != null),
        assert(tabs.length == children.length);

  @override
  _NestedTabViewState createState() => _NestedTabViewState();
}

class _NestedTabViewState extends State<NestedTabView>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: widget.tabs.length, vsync: this)
      ..addListener(() {
        if (_tabController.indexIsChanging) {
          setState(() {});
        }
      });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          widget.isCentered ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Padding(
          padding: widget.tabBarPadding,
          child: _buildTabBar(context),
        ),
        widget.keepAlive
            ? IndexedStack(
                index: _tabController.index,
                children: widget.children,
              )
            : widget.children[_tabController.index],
      ],
    );
  }

  Widget _buildTabBar(BuildContext context) {
    final height = widget.isTabFilled ? 40.0 : 32.0;
    final borderRadius = widget.isTabFilled ? 32.0 : 0.0;
    final color = widget.isTabFilled ? AppColors.light : Colors.transparent;
    final padding = widget.isTabFilled ? const EdgeInsets.all(4.0) : EdgeInsets.zero;

    return Theme(
      data: Theme.of(context).copyWith(
        hoverColor: Colors.transparent,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: Container(
        margin: widget.tabBarMargin,
        height: height,
        padding: padding,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: TabBar(
          isScrollable: true,
          controller: _tabController,
          indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(32.0),
            color: AppColors.primaryLight,
            boxShadow: [
              BoxShadow(
                blurRadius: 10.0,
                spreadRadius: 3.0,
                color: AppColors.primary.withOpacity(0.12),
              ),
            ],
          ),
          tabs: [
            for (int i = 0; i < widget.tabs.length; ++i)
              NestedTab(
                tab: widget.tabs[i],
                color: AppColors.dark,
              )
          ],
        ),
      ),
    );
  }
}

class NestedTabData {
  final String label;
  final IconData icon;

  NestedTabData({
    @required this.label,
    @required this.icon,
  })  : assert(label != null),
        assert(icon != null);
}

class NestedTab extends StatelessWidget {
  final Color color;
  final NestedTabData tab;

  const NestedTab({
    @required this.tab,
    @required this.color,
  })  : assert(tab != null),
        assert(color != null);

  @override
  Widget build(BuildContext context) {
    return ScaleAnimator(
      child: Tab(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              tab.icon,
              size: 18.0,
              color: color,
            ),
            const SizedBox(width: 6.0),
            AnimatedDefaultTextStyle(
              child: Text(tab.label),
              duration: const Duration(milliseconds: 200),
              style: AppTextStyles.small.bold.withColor(color),
            ),
          ],
        ),
      ),
    );
  }
}
