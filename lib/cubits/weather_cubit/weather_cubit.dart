import 'package:meta/meta.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:sahayatri/core/models/coord.dart';
import 'package:sahayatri/core/models/weather.dart';
import 'package:sahayatri/core/models/failure.dart';

import 'package:sahayatri/core/services/weather_service.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final String title;
  final WeatherService weatherService;

  WeatherCubit({
    @required this.title,
    @required this.weatherService,
  })  : assert(title != null),
        assert(weatherService != null),
        super(const WeatherInitial());

  Future<void> fetchWeather(Coord coord) async {
    emit(const WeatherLoading());
    try {
      final List<Weather> forecasts = await weatherService.fetchForecasts(coord);
      emit(WeatherSuccess(forecasts: forecasts));
    } on Failure catch (e) {
      print(e.error);
      emit(WeatherError(message: e.message));
    }
  }
}
