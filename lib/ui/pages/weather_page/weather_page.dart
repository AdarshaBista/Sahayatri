import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/coord.dart';

import 'package:sahayatri/app/constants/images.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/weather_cubit/weather_cubit.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/common/curved_appbar.dart';
import 'package:sahayatri/ui/widgets/indicators/busy_indicator.dart';
import 'package:sahayatri/ui/widgets/indicators/empty_indicator.dart';
import 'package:sahayatri/ui/widgets/indicators/error_indicator.dart';
import 'package:sahayatri/ui/pages/weather_page/widgets/weather_tab_view.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.cardColor,
      appBar: CurvedAppbar(
        title: context.watch<WeatherCubit>().title,
      ),
      body: BlocBuilder<WeatherCubit, WeatherState>(
        builder: (context, state) {
          if (state is WeatherLoading) {
            return const BusyIndicator(imageUrl: Images.weatherLoading);
          } else if (state is WeatherSuccess) {
            return WeatherTabView(forecasts: state.forecasts);
          } else if (state is WeatherError) {
            return ErrorIndicator(
              message: state.message,
              imageUrl: Images.weatherError,
            );
          } else {
            return const EmptyIndicator();
          }
        },
      ),
    );
  }
}

class WeatherPageArgs {
  final String name;
  final Coord coord;

  const WeatherPageArgs({
    @required this.name,
    @required this.coord,
  })  : assert(name != null),
        assert(coord != null);
}
