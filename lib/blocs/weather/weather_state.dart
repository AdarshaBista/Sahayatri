part of 'weather_bloc.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object> get props => [];
}

class WeatherInitial extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherSuccess extends WeatherState {
  final List<Weather> forecasts;

  const WeatherSuccess({
    @required this.forecasts,
  }) : assert(forecasts != null);

  @override
  List<Object> get props => [forecasts];
}

class WeatherError extends WeatherState {
  final String message;

  const WeatherError({
    @required this.message,
  }) : assert(message != null);

  @override
  List<Object> get props => [message];
}
