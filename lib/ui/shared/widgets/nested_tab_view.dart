import 'package:flutter/material.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/animators/scale_animator.dart';

class NestedTabView extends StatefulWidget {
  final List<Widget> children;
  final List<NestedTabData> tabs;
  final EdgeInsetsGeometry tabBarPadding;

  const NestedTabView({
    @required this.tabs,
    @required this.children,
    this.tabBarPadding = const EdgeInsets.symmetric(vertical: 8.0),
  })  : assert(tabs != null),
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: widget.tabBarPadding,
          child: _buildTabBar(context),
        ),
        widget.children[_tabController.index],
      ],
    );
  }

  Widget _buildTabBar(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        splashColor: Colors.transparent,
        hoverColor: Colors.transparent,
      ),
      child: Container(
        height: 34.0,
        color: AppColors.background,
        margin: const EdgeInsets.symmetric(horizontal: 20.0),
        child: TabBar(
          isScrollable: true,
          controller: _tabController,
          indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(32.0),
            gradient: LinearGradient(
              colors: [
                AppColors.accentColors[0],
                AppColors.accentColors[1],
              ],
            ),
          ),
          tabs: [
            for (int i = 0; i < widget.tabs.length; ++i)
              NestedTab(
                tab: widget.tabs[i],
                color: _tabController.index == i
                    ? AppColors.background
                    : AppColors.dark,
              ),
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
              size: 20.0,
              color: color,
            ),
            const SizedBox(width: 8.0),
            AnimatedDefaultTextStyle(
              child: Text(tab.label),
              style: AppTextStyles.small.bold.copyWith(color: color),
              duration: const Duration(milliseconds: 200),
            )
          ],
        ),
      ),
    );
  }
}
