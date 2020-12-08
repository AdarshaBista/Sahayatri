import 'package:meta/meta.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:sahayatri/locator.dart';

import 'package:sahayatri/core/models/coord.dart';
import 'package:sahayatri/core/models/weather.dart';
import 'package:sahayatri/core/models/app_error.dart';

import 'package:sahayatri/core/services/weather_service.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final String title;
  final WeatherService weatherService = locator();

  WeatherCubit({
    @required this.title,
  })  : assert(title != null),
        super(const WeatherInitial());

  Future<void> fetchWeather(Coord coord) async {
    emit(const WeatherLoading());
    try {
      final List<Weather> forecasts = await weatherService.fetchForecasts(coord);
      emit(WeatherSuccess(forecasts: forecasts));
    } on AppError catch (e) {
      emit(WeatherError(message: e.message));
    }
  }
}
