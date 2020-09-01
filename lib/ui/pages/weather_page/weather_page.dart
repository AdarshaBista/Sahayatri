import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/coord.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/weather_cubit/weather_cubit.dart';

import 'package:sahayatri/ui/shared/widgets/curved_appbar.dart';
import 'package:sahayatri/ui/shared/indicators/busy_indicator.dart';
import 'package:sahayatri/ui/shared/indicators/empty_indicator.dart';
import 'package:sahayatri/ui/shared/indicators/error_indicator.dart';
import 'package:sahayatri/ui/pages/weather_page/widgets/weather_tab_view.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CurvedAppbar(
        title: context.bloc<WeatherCubit>().title,
      ),
      body: BlocBuilder<WeatherCubit, WeatherState>(
        builder: (context, state) {
          if (state is WeatherLoading) {
            return const BusyIndicator();
          } else if (state is WeatherSuccess) {
            return WeatherTabView(forecasts: state.forecasts);
          } else if (state is WeatherError) {
            return ErrorIndicator(message: state.message);
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
