part of 'weather_bloc.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object> get props => [];
}

class WeatherFetched extends WeatherEvent {
  final Coord coord;

  const WeatherFetched({
    @required this.coord,
  }) : assert(coord != null);

  @override
  List<Object> get props => [coord];
}
