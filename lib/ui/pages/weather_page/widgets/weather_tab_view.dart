import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/weather.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/animators/slide_animator.dart';
import 'package:sahayatri/ui/pages/weather_page/widgets/weather_tab.dart';
import 'package:sahayatri/ui/pages/weather_page/widgets/weather_detail.dart';
import 'package:sahayatri/ui/pages/weather_page/widgets/curve_background.dart';

class WeatherTabView extends StatefulWidget {
  final List<Weather> forecasts;

  const WeatherTabView({
    @required this.forecasts,
  }) : assert(forecasts != null);

  @override
  _WeatherTabViewState createState() => _WeatherTabViewState();
}

class _WeatherTabViewState extends State<WeatherTabView>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: widget.forecasts.length, vsync: this)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: CurveBackground(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildTabView(),
          _buildTabBar(),
        ],
      ),
    );
  }

  Widget _buildTabView() {
    return Expanded(
      flex: 7,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: TabBarView(
          controller: _tabController,
          physics: const BouncingScrollPhysics(),
          children: widget.forecasts
              .map(
                (weather) => Center(
                  child: WeatherDetail(weather: weather),
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    return Expanded(
      flex: 3,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: TabBar(
          isScrollable: true,
          controller: _tabController,
          physics: const BouncingScrollPhysics(),
          indicator: const BoxDecoration(color: Colors.transparent),
          tabs: [
            for (int i = 0; i < widget.forecasts.length; ++i)
              SlideAnimator(
                begin: Offset(0.0, 0.4 + i * 0.2),
                child: WeatherTab(
                  isToday: i == 0,
                  weather: widget.forecasts[i],
                  color: _tabController.index == i ? AppColors.primary : AppColors.light,
                ),
              )
          ],
        ),
      ),
    );
  }
}
