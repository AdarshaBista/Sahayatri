import 'package:meta/meta.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:sahayatri/core/models/coord.dart';
import 'package:sahayatri/core/models/weather.dart';
import 'package:sahayatri/core/models/failure.dart';

import 'package:sahayatri/core/services/weather_service.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherService weatherService;

  WeatherBloc({
    @required this.weatherService,
  }) : assert(weatherService != null);

  @override
  WeatherState get initialState => WeatherInitial();

  @override
  Stream<WeatherState> mapEventToState(WeatherEvent event) async* {
    if (event is WeatherFetched) {
      yield WeatherLoading();
      try {
        final List<Weather> forecasts = await weatherService.fetchWeather(event.coord);
        yield WeatherSuccess(forecasts: forecasts);
      } on Failure catch (e) {
        print(e.error);
        yield WeatherError(message: e.message);
      }
    }
  }
}
