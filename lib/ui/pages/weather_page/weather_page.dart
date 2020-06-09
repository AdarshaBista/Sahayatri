import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/blocs/weather/weather_bloc.dart';
import 'package:sahayatri/blocs/destination_bloc/destination_bloc.dart';

import 'package:sahayatri/ui/shared/widgets/custom_appbar.dart';
import 'package:sahayatri/ui/shared/indicators/empty_indicator.dart';
import 'package:sahayatri/ui/shared/indicators/error_indicator.dart';
import 'package:sahayatri/ui/shared/indicators/loading_indicator.dart';
import 'package:sahayatri/ui/pages/weather_page/widgets/weather_tab_view.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage();

  @override
  Widget build(BuildContext context) {
    final destination = context.bloc<DestinationBloc>().destination;

    return Scaffold(
      appBar: CustomAppbar(
        elevation: 0.0,
        title: destination.name,
      ),
      body: BlocBuilder<WeatherBloc, WeatherState>(
        builder: (context, state) {
          if (state is WeatherLoading) {
            return const LoadingIndicator();
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
