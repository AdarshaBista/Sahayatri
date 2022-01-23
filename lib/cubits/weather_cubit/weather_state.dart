part of 'weather_cubit.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object> get props => [];
}

class WeatherInitial extends WeatherState {
  const WeatherInitial();
}

class WeatherLoading extends WeatherState {
  const WeatherLoading();
}

class WeatherSuccess extends WeatherState {
  final List<Weather> forecasts;

  const WeatherSuccess({
    required this.forecasts,
  });

  @override
  List<Object> get props => [forecasts];
}

class WeatherError extends WeatherState {
  final String message;

  const WeatherError({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}
